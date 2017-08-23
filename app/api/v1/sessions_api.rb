require 'uri'
require 'net/http'

module V1
  class SessionsApi < Grape::API
    namespace :sessions do
      format :json
      
      
      desc "Authenticate user and return user object / access token"
      params do
        optional :email, type: String, desc: "User Email"
        requires :password, type: String, desc: "User Password"
      end
      post do
        email = params[:email]
        password = params[:password]
        if email.present?
          user = User.where(email: email.downcase).first
        end
        if user.nil?
          # error!({error_code: 404, error_message: "Invalid Email or Password."},401)
          {result: 0, message: "用户名或者密码错误"}
          # return
        else
          if !user.valid_password?(password)
            # error!({error_code: 404, error_message: "Invalid Email or Password."},401)
            {result: 0, message: "用户名或者密码错误"}
            # return
          else
            user.ensure_authentication_token
            user.save
            # {status: 'ok', token: user.authentication_token}.to_json
            {result:1, message: User.api_render(user)}
          end
        end
      end
      
      desc "Destroy the access token"
      params do
        requires :access_token, type: String, desc: "User Access Token"
      end
      delete ':id' do
        puts "the "
        access_token = params[:access_token]
        puts "the at is #{access_token}"
        user = User.where(authentication_token: access_token).first
        if user.nil?
          # error!({error_code: 404, error_message: "Invalid access token."}, 401)
          { result: 0, message: "无效的授权"}
        else
          puts "#{user.username } will be destroy"
          user.reset_user_authentication_token
          # user.remove_authentication_token!
          { result: 1, message: user }
        end
      end
      
    end
  end
end