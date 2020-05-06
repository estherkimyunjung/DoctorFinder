
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

# def doctor_info(view)
#     doctor = find_doctor(view)
#     table = Terminal::Table.new :title => "#{doctor.name}".yellow, :style => {:width => 100, :padding_left => 3, :border_x => "=", :border_i => "="} do |t|
#         t << ["Address".upcase.green, "#{doctor.location.address}\n#{doctor.location.city}, #{doctor.location.state} #{doctor.location.zip_code}"]
#         t << :separator
#         t.add_row ["Specialty".upcase.green, doctor.specialty.name]
#         t << :separator 
#         t.add_row ["Phone Number".upcase.green, doctor.phone_number]
#         t << :separator 
#         t.add_row ["Gender".upcase.green, doctor.gender]
#     end
#     puts table  
#     puts " "       
# end 

# def new_fav_list_view
#     f_user = find_user(@user_name)
#     f_favorite = Favorite.all.select{|f_favs_list| f_favs_list.user_id == f_user.id}
#     if f_favs_list != []
#     large_table=Terminal::Table.new :title =>"#{@user_name}'s Favorites List".upcase.yellow, :style => {:width => 100, :padding_left => 3, :border_x => "=", :border_i => "="} do |t|
#     doc = f_favs_list.map{|f| f.doctor_id}.uniq
#     d_id = doc.each {|d| 
#     t << [("#{Doctor.find_by(id: d).name}"),("#{Doctor.find_by(id: d).specialty.name} Medicine, Phone Number: #{Doctor.find_by(id: d).phone_number}")]
#     t << :separator
#     }
#     end 
#     puts large_table 
#     task_menu
#     else
#     puts "You don't have fav_list."
#     task_menu
#     end
# end

def fav_list_view
    # f_favs_list = find_favs_list
    if find_favs_list != []
        large_table=Terminal::Table.new :title =>"#{@user_name}'s Favorites List".upcase.yellow, :style => {:width => 100, :padding_left => 3, :border_x => "=", :border_i => "="} do |t|
            doc = find_favs_list.map{|f| f.doctor_id}.uniq
            d_id = doc.each {|d| t << [("#{Doctor.find_by(id: d).name}"),("#{Doctor.find_by(id: d).specialty.name} Medicine, Phone Number: #{Doctor.find_by(id: d).phone_number}")]
                                t << :separator
                            }
        end
        puts large_table
    else
        puts "You don't have fav_list.".red
    end
end


def fav_list_table
    fav_list_view
    puts "Your Favorite's List is shown above.".green
    puts " "
    task_menu
end

# binding.pry
def add_fav_list(doctor)
    f_user = find_user(@user_name)
    f_doctor = find_doctor(doctor.name)
    new_fav = Favorite.create(user_id: f_user.id, doctor_id: f_doctor.id)
    update_favs_list = Favorite.all.select{|f_favs_list| f_favs_list.user_id == f_user.id}
    doc = update_favs_list.map{|f| f.doctor_id}.uniq
    d_id = doc.each {|d| 
    find_favs_list << [("#{Doctor.find_by(id: d).name}"),("#{Doctor.find_by(id: d).specialty.name} Medicine, Phone Number: #{Doctor.find_by(id: d).phone_number}")]
    }
    fav_list_view
    puts " "
    puts "Updated Your Favorite's List is shown above.".cyan
    puts " "

task_menu


#     f_user = find_user(@user_name)
#     f_doctor = find_doctor(doctor.name)
#     f_favs_list = fav_list_view.map{|fav_lites| fav_lists}
    
#     Favs_list.create(user_id: f_user.id, doctor_id: f_doctor.id)
#     update_favs_list = Favs_list.all.select{|f_favs_list| f_favs_list.user_id == f_user.id}
#     doc = update_favs_list.map{|f| f.doctor_id}.uniq
#     d_id = doc.each {|d| doctor_info("#{Doctor.find_by(id: d).name}") }
#     puts "Updated Your Favorite's List is shown above.".cyan
#     puts " "
#     task_menu

#     # f_favs_list = find_favs_list_inst
#     # if f_favs_list != []
#     #     doc = f_favs_list.map{|f| f.doctor_id}.uniq
#     #     d_id = doc.each {|d| doctor_info("#{Doctor.find_by(id: d).name}") }
            
#     # else
#     #     puts "This doctor is already in your fav_list.".red
#     # end
end


# # def update_fav_list(doctor_instance)
# #     # f_user = find_user(@user_name)
# #     # f_doctor = find_doctor(doctor_instance.name)
# #     # Favs_list.create(user_id: f_user.id, doctor_id: f_doctor.id)
# #     # update_favs_list = Favs_list.all.select{|f_favs_list| f_favs_list.user_id == f_user.id}
# #     # doc = update_favs_list.map{|f| f.doctor_id}.uniq
# #     # d_id = doc.each {|d| doctor_info("#{Doctor.find_by(id: d).name}") }
# #     # task_menu
# #     update_info = $prompt.select("What info would you like to update?") do |menu|
# #         menu.choice 'rating', 1
# #         menu.choice 'comments', 2
# #     end 

# #     if update_info == 1
# #         search_favs_rate("Rating")
# #     elsif update_info == 2
# #         search_favs_comment("Comments")
# #     end

# #     def search_favs_rate(type)
        
# #         fav_list= Favs_list.all.find_by(rating: type)
# #         fav_lists = Doctor.all.where(specialty_id: specialty.id)
# #         selection= specialty_list.all.collect do |inst| inst.name end 
# #             view = $prompt.select("The following doctors practice #{type} medicine. Please choose a doctor to continue:".blue, selection)
# #             show_doctor_info(view)
# #     end 
# #     def search_favs_comment(type)
        
# #         fav_list= Favs_list.all.find_by(rating: type)
# #         specialty_list = Doctor.all.where(specialty_id: specialty.id)
# #         selection= specialty_list.all.collect do |inst| inst.name end 
# #             view = $prompt.select("The following doctors practice #{type} medicine. Please choose a doctor to continue:".blue, selection)
# #             show_doctor_info(view)
# #     end 
    
    
# # end


def delete_fav_list
    fav_list_view
    f_user = find_user(@user_name)
    doctor_name = $prompt.ask("Please enter your doctor name that you would like to delete.")
    f_doctor = find_doctor(doctor_name)
    if !f_doctor
        puts "Your doctor's name cannot be found in favorite list.".red  

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
            puts "Your Favorite's List has been updated please review above".cyan
            puts " "
        else
            puts "You don't have Favorite to delete.".red 
        end
    end
    task_menu
end


def displayInfo(name)
    puts "Hi #{name}! Welcome to Doctor Finder!".cyan
    puts " "
end


