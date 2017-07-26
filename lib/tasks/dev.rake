 require 'csv'
  namespace :dev do

   task :import_registration_csv_file => :environment do
     event = Event.find_by_friendly_id("fullstack-meetup")
     tickets = event.tickets

     success = 0
     failed_records = []

     CSV.foreach("#{Rails.root}/tmp/registrations.csv") do |row|
       registration = event.registrations.new( :status => "confirmed",
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
         failed_records << [row, registration]
       end
     end

     puts "总共汇入 #{success} 笔，失败 #{failed_records.size} 笔"

     failed_records.each do |record|
      puts "#{record[0]} ---> #{record[1].errors.full_messages}"
     end

  end

    task :fake_event_and_registrations => :environment do
      event = Event.create!( :status => "public", :name => "全栈营 Meetup")
      t1 = event.tickets.create!( :name => "Guest", :price => 0)
      t2 = event.tickets.create!( :name => "VIP 第一期", :price => 199)
      t3 = event.tickets.create!( :name => "VIP 第二期", :price => 199)

      1000.times do |i|
        event.registrations.create!( :status => ["pending", "confirmed"].sample,
                                     :ticket => [t1,t2,t3].sample,
                                     :name => Faker::Cat.name, :email => Faker::Internet.email,
                                     :cellphone => "12345678", :bio => Faker::Lorem.paragraph,
                                     :created_at => Time.now - rand(10).days - rand(24).hours )
      end

      puts "Let's visit http://localhost:3000/admin/events/fullstack-meetup/registrations"
    end
  task :fake => :environment do
    User.delete_all
    Event.delete_all

    users = []
    users << User.create!( :email => "admin@example.org", :password => "12345678" )

    10.times do |i|
      users << User.create!( :email => Faker::Internet.email, :password => "12345678")
      puts "Generate User #{i}"
    end

    20.times do |i|
      topic = Event.create!( :name => Faker::Cat.name,
                             :description => Faker::Lorem.paragraph,
                             :user_id => users.sample.id )
      puts "Generate Event #{i}"
    end
  end

end
