
def userInfo
    user_name = $prompt.ask("Please enter your user name")
<<<<<<< HEAD
    @user_name = user_name

=======
    @user_name = user_name 
>>>>>>> master
    if find_user(user_name)
        displayInfo(user_name)
    else
        p "User name cannot be found." 
        puts "Select option"
        sign_up(user_name)
    end
end


<<<<<<< HEAD
# def option(user_name)
#     find_user(user_name)
    
#     list = ["Sign up your account",
#     "Search doctor by location",
#     "Search doctor by specialty",
#     "Create your favorite doctor lists",
#     "View your favorite doctor lists",
#     "Delete doctor from your lists",
#     "Welcome",
#     "Exit"]
    
#     input = $prompt.select("*".green,list)
#     case input
#     when list[0]
#         User.create(name: user_name)
#         userInfo
#         option(user_name)
#     # when list[1]
#     # when list[2]
#     when list[3]
#         add_fav_list
#     when list[4]
#         find_fav_list
#     # when list[5]
#     when list[6]
#         system "clear"
#         start
#     when list[7]
#         puts @a.asciify("Thanks for using our service !").green
#     end       
# end


=======
>>>>>>> master
def sign_up(user_name)
    list = ["Try again", "Create an account"]
    input = $prompt.select("*".green,list)

    case input
    when list[0]
        system "clear"
        userInfo
    when list[1]
<<<<<<< HEAD
        User.create(name: @user_name).save
=======
       user_name= User.create(name: user_name).save
>>>>>>> master
        userInfo
    end
end


def find_user(user_name)
    user= User.find_by(name: user_name)
end


def find_doctor(doctor_name)
    doctor = Doctor.find_by(name: doctor_name)
end

<<<<<<< HEAD
def find_fav_list
    # user_name = $prompt.ask("Please enter your user name")
=======
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
>>>>>>> master
    f_user = find_user(@user_name)
    f_favs_list = Favs_list.all.select{|f_favs_list| f_favs_list.user_id == f_user.id}
    
    if f_favs_list != []
        doc = f_favs_list.map{|f| f.doctor_id}.uniq
        d_id = doc.each {|d| doctor_info("#{Doctor.find_by(id: d).name}") }
            
    else
        puts "You don't have fav_list."
    end
end

<<<<<<< HEAD
def add_fav_list
    # user_name = $prompt.ask("Please enter your user name")
    f_user = find_user(@user_name)
    doctor_name = $prompt.ask("Please enter your doctor name")
    f_doctor = find_doctor(doctor_name)
=======

def find_fav_list
    fav_list_view
    task_menu
end


def add_fav_list(doctor_instance)
    f_user = find_user(@user_name)
    f_doctor = find_doctor(doctor_instance.name)
>>>>>>> master
    Favs_list.create(user_id: f_user.id, doctor_id: f_doctor.id)
    update_favs_list = Favs_list.all.select{|f_favs_list| f_favs_list.user_id == f_user.id}
    doc = update_favs_list.map{|f| f.doctor_id}.uniq
    d_id = doc.each {|d| doctor_info("#{Doctor.find_by(id: d).name}") }
    task_menu
end


def delete_fav_list
<<<<<<< HEAD
    # user_name = $prompt.ask("Please enter your user name")
    f_user = find_user(@user_name)
    doctor_name = $prompt.ask("Please enter your doctor name")
=======
    fav_list_view
    f_user = find_user(@user_name)
    doctor_name = $prompt.ask("Please enter your doctor name that you would like to delete.")
>>>>>>> master
    f_doctor = find_doctor(doctor_name)
    if !f_doctor
        p "Your doctor's name cannot be found in fav_list." 
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


