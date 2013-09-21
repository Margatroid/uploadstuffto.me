module AuthHelper
  def register(email, key)
    visit '/register'
    pass = 'password'

    fill_in 'Email',                 :with => email
    fill_in 'Password',              :with => pass
    fill_in 'Password confirmation', :with => pass

    fill_in 'Invite key', :with => key if key

    click_button 'Register'
  end

  def login(email, pass)
    visit '/login'
    fill_in 'Email',    :with => email
    fill_in 'Password', :with => pass
    click_button 'Sign in'
  end
end

module UploadHelper
  def upload_file
    visit '/'
    attach_file('File', File.expand_path('spec/fixtures/chicken_rice.jpg'))
    click_button 'Upload image'
  end
end