require 'csv'
class RegistrationImport < ApplicationRecord

  mount_uploader :csv_file, RegistrationImportCsvUploader

  validates_presence_of :csv_file

  belongs_to :event
  belongs_to :user

  serialize :error_messages, JSON

  def process!
    csv_string = self.csv_file.read.force_encoding('utf-8')
    tickets = self.event.tickets

    success = 0
    failed_records = []

    CSV.parse(csv_string) do |row|
      registration = self.event.registrations.new( :status => "confirmed",
                                    :ticket => tickets.find{ |t| t.name == row[0] },
                                    :name => row[1],
                                    :email => row[2],
                                    :cellphone => row[3],
                                    :website => row[4],
                                    :bio => row[5],
                                    :created_at => Time.parse(row[6]) )

       if registration.save
         success += 1
       else
         failed_records << [row, registration.errors.full_messages]
       end
    end

    self.status = "imported"
    self.success_count = success
    self.total_count = success + failed_records.size
    self.error_messages = failed_records

    self.save!
  end

end
