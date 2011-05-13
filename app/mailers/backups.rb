class Backups < ActionMailer::Base
  default :from => 'backup@sketchlabhq.com'
  default :to => 'backup@sketchlabhq.com'
  default :subject => "Sketch Lab Backup: #{Time.now.strftime('%m/%d/%Y -- %H:%M:%S')}"

  def backup(backup_location)
    # Attach the database backup
    attachments["db.dump"] = File.read(backup_location)
    mail
  end
end
