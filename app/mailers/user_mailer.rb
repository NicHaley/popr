class UserMailer < ActionMailer::Base
	default from: 'popr.mailer@gmail.com'

	def activation_needed_email(user)
		@user = user
		@url  = "http://localhost:3000/users/#{@user.activation_token}/activate"
		mail(to: @user.email, subject: 'Activate Your Popr Account')
	end

	def activation_success_email(user)
		@user = user
		@url  = "http://localhost:3000/"
		mail(to: @user.email, subject: 'Popr Account Activated')
	end

end
