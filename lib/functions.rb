def find_user(user_name)
    user = User.find_by(name: user_name)
end

def user
    find_user(@user_name)
end


def find_doctor(doctor_name)
    doctor = Doctor.find_by(name: doctor_name)
end


def find_favs_list
    favs_list = Favorite.all.select{|favs_list| favs_list.user_id == user.id}
end


def good_bye
    puts " "
    puts "Thank you for using Doctor Finder!".cyan
    puts " "
    exit 
end


def updated_message
    puts " "
    puts "Your Favorites List has been updated shown above.".cyan
    puts " "
end


def verify_user
    user_name = $prompt.ask("Please enter your user name:")
    @user_name = user_name 
    if find_user(user_name)
        displayInfo(user_name)
    else
        puts "User name cannot be found.".red
        puts "Select option"
        sign_up
    end
end


def userInfo
    list = ["Sign In", "Sign Up", "Good Bye!"]
    input = $prompt.select("*".green,list)
    
    case input
    when list[0]
        verify_user
    when list[1]
        sign_up
    when list[2]
        good_bye
    end
end


def sign_up
    list = ["Try again", "Create an account", "Good Bye!"]
    input = $prompt.select("*".green,list)

    case input
    when list[0]
        system "clear"
        verify_user
    when list[1]
        user_name= User.create(name: @user_name).save
        displayInfo(@user_name)
        task_menu
    when list[2]
        good_bye 
    end
end


def fav_list_view
    if find_favs_list != []
        large_table=Terminal::Table.new :title =>"#{@user_name}'s Favorites List".upcase.yellow, :style => {:width => 125, :padding_left => 3, :border_x => "=", :border_i => "="} do |t|
            doc = find_favs_list.map{|f| f.doctor_id}.uniq
            # doc_rate = doc.favorites.map{|favs| favs.rating}
            # doc_com = doc.favorites.map{|favs| favs.comments}
            # doctors = Doctor.find(d)
            d_id = doc.each {|d| t << :separator
            t << [("#{Doctor.find_by(id: d).name}".green),("#{Doctor.find_by(id: d).specialty.name} Medicine, Phone Number: #{Doctor.find_by(id: d).phone_number}")]
                t << [("Rating : #{Doctor.find(d).favorites.map{|f| f.rating}.last}"),("Comment : #{Doctor.find(d).favorites.map{|f| f.comments}.last}")]
            }
        end
        puts " "
        puts large_table
    else
        puts "You don't have favorite list.".red
        puts " "
        task_menu
    end
end


def fav_list_table
    fav_list_view
    puts " "
    puts "Your Favorites List shown above.".cyan
    puts " "
    task_menu
end


def add_fav_list(doctor)
    if user.favorites.find{|favs| favs.doctor_id == doctor.id}
        puts " "
        puts "You already have in your Favorites List".red
        puts " "
    else
        new_fav = Favorite.create(user_id: user.id, doctor_id: doctor.id)
        find_favs_list << new_fav
        doc = find_favs_list.map{|f| f.doctor_id}.uniq
        d_id = doc.each {|d| 
            find_favs_list << [("#{Doctor.find_by(id: d).name}"),("#{Doctor.find_by(id: d).specialty.name} Medicine, Phone Number: #{Doctor.find_by(id: d).phone_number}")]
        }
        fav_list_view
        updated_message
    end
    task_menu
end

def update_fav_list
    fav_list_view
    
    doctor_name = $prompt.ask("Please update doctor's rating and comment.")
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
            update_fav_list
        when list[1]
            task_menu
        end
        
    else
        favorites = user.favorites.select{|favs| favs.doctor_id == doctor.id}
        new_rating = $prompt.ask("Please enter new ratings.")
        new_comment = $prompt.ask("Please write a comments.")
        comment = favorites.map{|favorites| favorites.comments}.uniq << new_comment
        ratings = favorites.map{|favorites| favorites.rating}.uniq << new_rating
        # puts comment.last
        # puts ratings.last
# d8.favorites.map{|favs| favs.user_id }
# u1.favorites.map{|favs| favs.doctor_id}
# u1.favorites.select{|favs| favs.doctor_id == d3.id}
# binding.pry
# 0

        large_table=Terminal::Table.new :title =>"#{@user_name}'s Favorites List".upcase.yellow, :style => {:width => 100, :padding_left => 3, :border_x => "=", :border_i => "="} do |t|
            doc = find_favs_list.map{|f| f.doctor_id}.uniq
            d_id = doc.each {|d| t << :separator
                t << [("#{Doctor.find_by(id: d).name}".green),("#{Doctor.find_by(id: d).specialty.name} Medicine, Phone Number: #{Doctor.find_by(id: d).phone_number}")]
                t << [("Ratings : #{ratings.last}"), ("Comments : #{comment.last}")]
            }
                # if doc.id == doctor.id 
                #     {|d| t << :separator
                #         t << [("#{Doctor.find_by(id: d).name}".green),("#{Doctor.find_by(id: d).specialty.name} Medicine, Phone Number: #{Doctor.find_by(id: d).phone_number}")]
                #         t << [("Ratings : #{ratings.last}"), ("Comments : #{comment.last}")]
                #     }
                # else
                #     {|d| t << :separator
                #     t << [("#{Doctor.find_by(id: d).name}".green),("#{Doctor.find_by(id: d).specialty.name} Medicine, Phone Number: #{Doctor.find_by(id: d).phone_number}")]
                #     }
                # end
            
        end
        puts " "
        puts large_table
        updated_message
    end
    task_menu
        
end


def delete_fav_list
    fav_list_view
    # user = find_user(@user_name)
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
        Favorite.find_by(user_id: user.id, doctor_id: doctor.id).delete
        fav_list_view
        updated_message
    end
    task_menu
end


def displayInfo(name)
    puts "Hi #{name}! Welcome to Doctor Finder!".cyan
    puts " "
end
