class UserMailer < ActionMailer::Base
	default from: 'popr.mailer@gmail.com'

	def activation_needed_email(user)
		@user = user
		@url  = "http://infinite-woodland-9098.herokuapp.com//users/#{@user.activation_token}/activate"
		mail(to: @user.email, subject: 'Activate Your Popr Account')
	end

	def activation_success_email(user)
		@user = user
		@url  = "http://infinite-woodland-9098.herokuapp.com/"
		mail(to: @user.email, subject: 'Popr Account Activated')
	end

end
