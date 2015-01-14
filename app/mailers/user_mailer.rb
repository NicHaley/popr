class UserMailer < ActionMailer::Base
	default from: 'popr.mailer@gmail.com'

	def activation_needed_email(user)
		@user = user
		mail(to: @user.email, subject: 'Sample Email')
	end
end
