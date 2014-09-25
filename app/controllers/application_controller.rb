class ApplicationController < ActionController::API
	include ActionController::HttpAuthentication::Token::ControllerMethods

 protected
 	def current_user
 		token = request.headers['Authorization'].split('"')[1] if request.headers['Authorization']
 		@current_user ||= User.find_by(auth_token: token)
 	end

 	def authenticate
 		authenticate_token || render_unauthorized
 	end

 	def authenticate_token
 		authenticate_with_http_token do |token, options|
 			User.find_by(auth_token: token)
 		end
 	end

 	def render_unauthorized
 		self.headers['WWW-Authenticate'] = 'Token realm="Application"'
    render json: 'Bad credentials', status: 401
 	end
end
