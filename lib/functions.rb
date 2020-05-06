
def userInfo
    user_name = $prompt.ask("Please enter your user name:")
    @user_name = user_name 
    if find_user(user_name)
        displayInfo(user_name)
    else
        puts "User name cannot be found.".red
        puts "Select option".cyan
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


def find_favs_list
    f_user = find_user(@user_name)
    f_favs_list = Favorite.all.select{|f_favs_list| f_favs_list.user_id == f_user.id}
end


def fav_list_view
    if find_favs_list != []
        large_table=Terminal::Table.new :title =>"#{@user_name}'s Favorites List".upcase.yellow, :style => {:width => 100, :padding_left => 3, :border_x => "=", :border_i => "="} do |t|
            doc = find_favs_list.map{|f| f.doctor_id}.uniq
<<<<<<< HEAD
            d_id = doc.each {|d| t << :separator
                t << [("#{Doctor.find_by(id: d).name}"),("#{Doctor.find_by(id: d).specialty.name} Medicine, Phone Number: #{Doctor.find_by(id: d).phone_number}")]
            }
=======
            d_id = doc.each {|d| t << [("#{Doctor.find_by(id: d).name}".upcase.green),("#{Doctor.find_by(id: d).specialty.name} Medicine, Phone Number: #{Doctor.find_by(id: d).phone_number}")]
                                t << :separator
                            }
>>>>>>> a5fcc3ed0a9ae3d6b45fb648df8970d67287519c
        end
        puts large_table
    else
<<<<<<< HEAD
        puts "You don't have favorite list.".red
        puts " "
        task_menu
=======
        puts "You don't have a favorites list.".red
>>>>>>> Stephanie
    end
end


def fav_list_table
    fav_list_view
    puts "Your Favorites List is shown above.".green
    puts " "
    task_menu
end

def add_fav_list(doctor)
    user = find_user(@user_name)
    doctor = find_doctor(doctor.name)
    new_fav = Favorite.create(user_id: user.id, doctor_id: doctor.id)
    
    if find_favs_list.map{|lists| lists.id == new_fav.id}
<<<<<<< HEAD
        puts " "
        puts "You already have in your Favorite's List".red
        puts " "
    else
        update_favs_list = Favorite.all.select{|f_favs_list| f_favs_list.user_id == f_user.id}
        doc = update_favs_list.map{|f| f.doctor_id}.uniq
        d_id = doc.each {|d| 
            find_favs_list << [("#{Doctor.find_by(id: d).name}"),("#{Doctor.find_by(id: d).specialty.name} Medicine, Phone Number: #{Doctor.find_by(id: d).phone_number}")]
        }
        fav_list_view
        puts " "
        puts "Updated Your Favorite's List is shown above.".cyan
        puts " "
    end
    task_menu
=======
    puts " "
    puts "You already have in your Favorite's List".red
    puts " "
else
    update_favs_list = Favorite.all.select{|f_favs_list| f_favs_list.user_id == f_user.id}
    doc = update_favs_list.map{|f| f.doctor_id}.uniq
    d_id = doc.each {|d| 
    find_favs_list << [("#{Doctor.find_by(id: d).name}"),("#{Doctor.find_by(id: d).specialty.name} Medicine, Phone Number: #{Doctor.find_by(id: d).phone_number}")]
<<<<<<< HEAD
}
fav_list_view
puts " "
puts "Updated Your Favorite's List is shown above.".cyan
puts " "
end
=======
    }
    fav_list_view
    puts " "
    puts "Updated Your Favorites List is shown above.".cyan
    puts " "

>>>>>>> Stephanie
task_menu
>>>>>>> a5fcc3ed0a9ae3d6b45fb648df8970d67287519c
end

# binding.pry
def update_fav_list

end


def delete_fav_list
    fav_list_view
<<<<<<< HEAD
    user = find_user(@user_name)
    doctor_name = $prompt.ask("Please enter your doctor name that you would like to delete.")
    doctor = find_doctor(doctor_name)
    if !doctor
        puts " "
        puts "Doctor's name cannot be found in favorite list.".red
        puts " "  
=======
    f_user = find_user(@user_name)
    doctor_name = $prompt.ask("Please enter a doctor's name that you would like to delete.")
    f_doctor = find_doctor(doctor_name)
    if !f_doctor
        puts "Your doctor's name cannot be found in favorite list.".red  
>>>>>>> Stephanie

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
<<<<<<< HEAD
        d_favs_list = Favorite.find_by(user_id: user.id, doctor_id: doctor.id)
        d_favs_list.delete
        fav_list_view
        puts " "
        puts "Your Favorite's List has been updated please review above".cyan
        puts " "
=======
        d_favs_list = Favorite.find_by(user_id: f_user.id, doctor_id: f_doctor.id)
        if d_favs_list != []
            d_favs_list.delete
            update_favs_list = Favorite.all.select{|f_favs_list| f_favs_list.user_id == f_user.id}
            doc = update_favs_list.map{|f| f.doctor_id}.uniq
            d_id = doc.each {|d| 
            find_favs_list << [("#{Doctor.find_by(id: d).name}"),("#{Doctor.find_by(id: d).specialty.name} Medicine, Phone Number: #{Doctor.find_by(id: d).phone_number}")]
            }
            fav_list_view
            puts " "
            puts "Your Favorites List has been updated please review above".cyan
            puts " "
        else
            puts "You don't have a Favorites list to delete.".red 
        end
>>>>>>> Stephanie
    end
    task_menu
end


def displayInfo(name)
    puts "Hi #{name}! Welcome to Doctor Finder!".cyan
    puts " "
end

