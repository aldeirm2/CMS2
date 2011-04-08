class UserMailer < ActionMailer::Base
    default :from => "Dev-Enviorment@ivi.com"

  def comment_email(comment)
    @comment = comment
    @cp = @comment.review.critical_process
    roles = @cp.roles
    roles.each do |role|
      recipients = role.users
      recipients.each do |rec|
        @user = rec
        mail(:to => @user.email, :subject => "New Comment for CP #{@comment.review.critical_process.title}")
      end
    end
  end

  def new_version(cp)
    @cp = cp
    roles = @cp.roles
    roles.each do |role|
      recipients = role.users
      recipients.each do |rec|
        @user = rec
        mail(:to => @user.email, :subject => "New Version created for CP #{@cp.title}")
      end
    end
  end

  def review_edit(cp)
    @cp = cp
    roles = @cp.roles
    roles.each do |role|
      recipients = role.users
      recipients.each do |rec|
        @user = rec
        mail(:to => @user.email, :subject => "Changes made for CP #{@cp.title}")
      end
    end
  end
end
