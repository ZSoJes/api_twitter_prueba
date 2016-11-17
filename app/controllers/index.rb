get '/' do
  # La siguiente linea hace render de la vista 
  # que esta en app/views/index.erb
  erb :index
end

post '/fetch' do
  puts "Publicar un nuevo tweet..."
  @tweet = params[:mensaje]
  unless @tweet == ""
    CLIENT.update(@tweet)
  end

  redirect to "/#{params[:userName]}"
end

# get '/:handle' do
#   user = params[:handle]
#   user_data = CLIENT.user_search(user).first

#   @user_id = user_data.id
#   @full_name =user_data.name
#   @url = user_data.profile_image_url("original")

#   @tweets = CLIENT.user_timeline(user, count: 8)
#   erb :twitter_handle
# end

get '/:username' do
  user = params[:username]

  tuit_user = TwitterUser.find_or_create_by(name_user: user)
  tuit_log = Tweet.where(id: tuit_user.id)
  user_data = CLIENT.user_search(user).first

  @full_name = user_data.name
  @url = user_data.profile_image_url("original")

   @tweets_c = CLIENT.user_timeline(user_data.user_name)

   if tuit_log.empty?                   # La base de datos no tiene tweets?  
    @tweets_c.each do  |t|
      Tweet.create(twitter_user_id: user_data.id, tweet_w: t.text)
    end
  end

  if Time.now - @tweets_c.first.created_at > 700
     @tweets_c.each do  |t|
       if Tweet.find_by(tweet_w: t.text).nil?
         Tweet.create(twitter_user_id: user_data.id, tweet_w: t.text)
       end
     end
  end


  # Se hace una petición por los ultimos 10 tweets a la base de datos. 
  @tweets = Tweet.where(twitter_user_id: user_data.id).order(:created_at).limit(10)
  erb :twitter_handle
end