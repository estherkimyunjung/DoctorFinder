
def userInfo
    user_name = $prompt.ask("Please enter your user name:")
    @user_name = user_name 
    if find_user(user_name)
        displayInfo(user_name)
    else
        p "User name cannot be found." 
        puts "Select option"
        sign_up(user_name)
    end
end


# def option($user_name)
#     find_user($user_name)
    
#     list = ["Sign up your account",
#     "Search doctor by location",
#     "Search doctor by specialty",
#     "Create your favorite doctor lists",
#     "View your favorite doctor lists",
#     "Delete doctor from your lists",
#     "Welcome",
#     "Exit"]
    
#     input = $prompt.select("*".,list)
#     case input
#     when list[0]
#         User.create(name: $user_name)
#         userInfo
#         option($user_name)
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
#         puts @a.asciify("Thanks for using our service !").
#     end       
# end


def sign_up(user_name)
    list = ["Try again", "Create an account"]

    input = $prompt.select("*".blue,list)
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

def find_fav_list
    # user_name = $prompt.ask("Please enter your user name")
    f_user = find_user(@user_name)
    f_favs_list = Favs_list.all.select{|f_favs_list| f_favs_list.user_id == f_user.id}
    if f_favs_list != []
        p f_favs_list
    else
        puts "You don't have fav_list."
    end
    task_menu
end

def add_fav_list(doctor_instance)
    # user_name = $prompt.ask("Please enter your user name")
    f_user = find_user(@user_name)
    # doctor_name = $prompt.ask("Please enter your doctor name")
    f_doctor = find_doctor(doctor_instance.name)
    Favs_list.create(user_id: f_user.id, doctor_id: f_doctor.id)
    update_favs_list = Favs_list.all.select{|f_favs_list| f_favs_list.user_id == f_user.id}
    p update_favs_list
    task_menu
end

def delete_fav_list
    # user_name = $prompt.ask("Please enter your user name")
    find_fav_list 
    f_user = find_user(@user_name)
    doctor_name = $prompt.ask("Please enter your doctor name that you would like to delete.")
    f_doctor = find_doctor(doctor_name)
    d_favs_list = Favs_list.find_by(user_id: f_user.id, doctor_id: f_doctor.id)
    d_favs_list.delete
    update_favs_list = Favs_list.all.select{|f_favs_list| f_favs_list.user_id == f_user.id}
    p update_favs_list
    task_menu
end

def displayInfo(name)
    p "Hi #{name}! Welcome to Doctor Finder!"
end


