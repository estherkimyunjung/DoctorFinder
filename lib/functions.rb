
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
            d_id = doc.each {|d| t << :separator
                t << [("#{Doctor.find_by(id: d).name}"),("#{Doctor.find_by(id: d).specialty.name} Medicine, Phone Number: #{Doctor.find_by(id: d).phone_number}")]
            }
        end
        puts large_table
    else
        puts "You don't have favorite list.".red
        puts " "
        task_menu
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
end

# binding.pry
def update_fav_list

end


def delete_fav_list
    fav_list_view
    user = find_user(@user_name)
    doctor_name = $prompt.ask("Please enter your doctor name that you would like to delete.")
    doctor = find_doctor(doctor_name)
    if !doctor
        puts " "
        puts "Doctor's name cannot be found in favorite list.".red
        puts " "  

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
        d_favs_list = Favorite.find_by(user_id: user.id, doctor_id: doctor.id)
        d_favs_list.delete
        fav_list_view
        puts " "
        puts "Your Favorite's List has been updated please review above".cyan
        puts " "
    end
    task_menu
end


def displayInfo(name)
    puts "Hi #{name}! Welcome to Doctor Finder!".cyan
    puts " "
end

end 