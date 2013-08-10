Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '560733490656801', '23010397b9a1515ba9fc1274f8d9462f'
  provider :twitter, 'l4uzzYUWtWwXt7eu0jHGCQ', 'S52qsi577WhsMoovJ5eIKqF7qwEmA7XHHEFVeTIJuE'
  provider :vkontakte, '3814050', 'Ih9Ka7UXNv34zFwRITIw'
end