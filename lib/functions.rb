def userInfo
    user_name = $prompt.ask("Please enter your user name")

    if User.find_by(name: user_name)
        displayInfo(user_name)
    else
        p " Please check user name , it is not correct"
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
        User.create(name: user_name)
        userInfo
    end
end


def option(user)
    user = User.find_by(name: user_name)
    
    list = ["Sign up your account",
    "Search doctor by location",
    "Search doctor by specialty",
    "Create your favourite doctor lists",
    "View your doctor lists",
    "Delete doctor from your lists",
    "Welcome",
    "Exit"]
    
    input = $prompt.select("*".green,list)
    case input
    when list[0]
        user = User.create(name: user_name)
        displayInfo(user.name)
        option(user)
    # when list[1]
    # when list[2]
    # when list[3]
    # when list[4]
    # when list[5]
    when list[6]
        system "clear"
        start
    when list[7]
        puts @a.asciify("Thanks for using our service !").green
    end
        
end

def displayInfo(name)
    p "Hi #{name}!! Welcome to our DOCTOR SEARCH"
end


