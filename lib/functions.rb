
def userInfo
    user_name = $prompt.ask("Please enter your user name")
    @user_name = user_name 
    if find_user(user_name)
        displayInfo(user_name)
    else
        puts "User name cannot be found." 
        puts "Select option"
        sign_up(user_name)
    end
end


def sign_up(user_name)
    list = ["Try again", "Create an account"]
    input = $prompt.select("*".green,list)

    case input
    when list[0]
        system "clear"
        userInfo
    when list[1]
       user_name= User.create(name: user_name).save
        userInfo
    end
end


def find_user(user_name)
    user= User.find_by(name: user_name)
end


def find_doctor(doctor_name)
    doctor = Doctor.find_by(name: doctor_name)
end

def doctor_info(view)
    doctor_instance = Doctor.all.find_by(name: view)
    table = Terminal::Table.new :title => "#{doctor_instance.name}" do |t|
        t << ["Address", "#{doctor_instance.location.address}\n#{doctor_instance.location.city}, #{doctor_instance.location.state} #{doctor_instance.location.zip_code}"]
        t << :separator
        t.add_row ["Specialty", doctor_instance.specialty.name]
        t << :separator 
        t.add_row ["Phone Number", doctor_instance.phone_number]
    end
    puts table         
end 


def fav_list_view
    f_user = find_user(@user_name)
    f_favs_list = Favs_list.all.select{|f_favs_list| f_favs_list.user_id == f_user.id}
    
    if f_favs_list != []
        doc = f_favs_list.map{|f| f.doctor_id}.uniq
        d_id = doc.each {|d| doctor_info("#{Doctor.find_by(id: d).name}") }
            
    else
        puts "You don't have fav_list."
    end
end


def find_fav_list
    fav_list_view
    task_menu
end


def add_fav_list(doctor_instance)
    f_user = find_user(@user_name)
    f_doctor = find_doctor(doctor_instance.name)
    Favs_list.create(user_id: f_user.id, doctor_id: f_doctor.id)
    update_favs_list = Favs_list.all.select{|f_favs_list| f_favs_list.user_id == f_user.id}
    doc = update_favs_list.map{|f| f.doctor_id}.uniq
    d_id = doc.each {|d| doctor_info("#{Doctor.find_by(id: d).name}") }
    task_menu
end


def delete_fav_list
    fav_list_view
    f_user = find_user(@user_name)
    doctor_name = $prompt.ask("Please enter your doctor name that you would like to delete.")
    f_doctor = find_doctor(doctor_name)
    if !f_doctor
        puts "Your doctor's name cannot be found in fav_list." 

        list = ["Try again", "Go back to main menu"]
        input = $prompt.select("*".green,list)
    
        case input
        when list[0]
            system "clear"
            delete_fav_list
        when list[1]
            task_menu
        end
    
    else
        d_favs_list = Favs_list.find_by(user_id: f_user.id, doctor_id: f_doctor.id)
        if d_favs_list != []
            d_favs_list.delete
            update_favs_list = Favs_list.all.select{|f_favs_list| f_favs_list.user_id == f_user.id}
            doc = update_favs_list.map{|f| f.doctor_id}.uniq
            d_id = doc.each {|d| doctor_info("#{Doctor.find_by(id: d).name}") }
            puts "Your fav_list has been updated"
        else
            puts "You don't have fav_list to delete."
        end
    end
    task_menu
end


def displayInfo(name)
    p "Hi #{name}!! Welcome to our DOCTOR SEARCH"
end


