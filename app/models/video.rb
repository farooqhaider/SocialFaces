class Video < ActiveRecord::Base

  # Paperclip
  # http://www.thoughtbot.com/projects/paperclip
  has_attached_file :source,
    :path => "public/:attachment/:id/:basename.:extension",
    :url  => "/:attachment/:id/:basename.:extension"


  # Paperclip Validations
  validates_attachment_presence :source
  #validates_attachment_content_type :source, :content_type => 'video/quicktime'


  belongs_to :user, :class_name => "User", :foreign_key => "user_id"


  # Acts as State Machine
  # http://elitists.textdriven.com/svn/plugins/acts_as_state_machine
  acts_as_state_machine :initial => :pending
  state :pending
  state :converting
  state :converted, :enter => :set_new_filename
  state :error

  event :convert do
    transitions :from => :pending, :to => :converting
  end

  event :converted do
    transitions :from => :converting, :to => :converted
  end

  event :failed do
    transitions :from => :converting, :to => :error
  end





  def convert
  self.convert!
  success = system(convert_command)
  if success && $?.exitstatus == 0
    self.converted!
  else
    self.failed!
  end
  end

  protected

# This method creates the ffmpeg command that we'll be using
  def convert_command
    flv = File.join(File.dirname(source.path), "#{id}.flv")
    #File.open(flv, 'w')s
     #flv1 = File.join(File.dirname(source.path), "#{id}i.jpg")
   # command = <<-end_command
   # ffmpeg -i #{ source.path } -ar 22050 -ab 32 -acodec mp3
   #-s 480x360 -vcodec flv -r 25 -qscale 8 -f flv -y #{ flv }
   # end_command

    command = <<-end_command
    ffmpeg -i #{ source.path } -ar 44100 -ab 96 -f flv #{ flv }
    end_command
   # command.gsub!(/\s+/, " ")

    #command = <<-end_command
    #ffmpeg  -itsoffset -1  -i #{ source.path } -vcodec mjpeg -vframes 1 -an -f rawvideo -s 320x240 #{ flv1 }
    #end_command
   command.gsub!(/\s+/, " ")
  end

  # This update the stored filename with the new flash video file
  def set_new_filename
    update_attribute(:source_file_name, "#{id}.flv")
  end









end
