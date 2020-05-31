from django.shortcuts import render,redirect
from loginModule.models import *
from django.contrib import messages
from .forms import UserRegisterForm
import pyrebase
from django.contrib import  auth

firebaseConfig = {
    'apiKey': "AIzaSyBjo88XtIsKYcxKflSwb2iRnZSOTGENnQc",
    'authDomain': "foodzo-b3dfa.firebaseapp.com",
    'databaseURL': "https://foodzo-b3dfa.firebaseio.com",
    'projectId': "foodzo-b3dfa",
    'storageBucket': "foodzo-b3dfa.appspot.com",
    'messagingSenderId': "469452991715",
    'appId': "1:469452991715:web:43453648d314f3e9a029d6"
  };

firebase = pyrebase.initialize_app(firebaseConfig)
database = firebase.database()
auth = firebase.auth()

# Create your views here.
def home(request):
    return render(request,"loginModule/home.html")

def loginView(request):
    if request.method == 'POST':
        print("Gayyyaaaaaa")
        formData = request.POST
        emailId = formData['email']
        password = formData['password']
        try:
            user = auth.sign_in_with_email_and_password(emailId, password)
            session_id = user['localId']
            # request.session['uid'] = str(session_id)
            print("Login Huaaaaaaa")
            return redirect('/navigate/hotelInfo')
            print("returnnnnnnnnnn")

        except:
            message = "Invalid credentials"
            return render(request, "loginModule/login.html", {"msg": message})
    return render(request,"loginModule/login.html")


def signUpView(request):
    if request.method == 'POST':
        formData = request.POST
        email = formData['email']
        phoneNo = formData['phoneNo']
        username = formData['username']
        password = formData['password']
        # confirmPassword = formData['confirmpassword']
        ####
        user = auth.create_user_with_email_and_password(email, password)
        id = user['localId']
        data = {
            'username': username,
            'email': email,
            'phoneNo': phoneNo,
        }
        database.child("NGO").child(id).set(data)
        return redirect("/login/")
        # profile = Profile()
    return render(request,"loginModule/signUp.html")



# def register(request):
#     if request.method == 'POST':
#         form = UserRegisterForm(request.POST)
#         if form.is_valid():
#             form.save()
#             username = form.cleaned_data.get('username')
#             # messages.success(request,f'Account created for {username}! You can now login')
#             return redirect('login')
#     else:
#         form = UserRegisterForm()
#     return render(request, 'loginModule/signUp.html' , {'form' : form })



def postsignUp(request):
    formData = request.POST
    email = formData['email']
    phoneNo = formData['phoneNo']
    username = formData['username']
    password = formData['password']
    # confirmPassword = formData['confirmpassword']
    ####
    user = auth.create_user_with_email_and_password(email,password)
    id=user['localId']
    data={
        'username':username,
        'email':email,
        'phoneNo':phoneNo,
    }
    print("userrrrrrr")
    database.child("NGO").child(id).set(data)
    return render(request,"user/signIn.html")