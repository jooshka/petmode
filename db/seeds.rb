Menu.destroy_all
puts 'Create admin...'
#User.create!( email: 'admin@example.com', password: 'password', password_confirmation: 'password')

puts 'Create pet types...'
#PetType.create!( id: 1, name: 'cat')
#PetType.create!( id: 2, name: 'dog')

puts 'Create menu...'
[
  { text: 'Sale',          url: '#' },
  { text: 'News',          url: '#' },
  { text: 'Good hands', url: '#' },
  { text: 'Competitions',  url: '#' },
  { text: 'Copulations',   url: '#' },
  { text: 'Pet shop',      url: '#' },
  { text: 'Experts',       url: '#' },
  { text: 'Exhibitions',   url: '#' }
].each_with_index do |v, i|
   Menu.create( kind: Menu.kinds[:head], order_num: (i+1)*10, text: v[:text], url: v[:url] );
end

[
  { text: 'Sale',          url: '#' },
  { text: 'Pet shop',      url: '#' },
  { text: 'News',          url: '#' },
  { text: 'Copulations',   url: '#' },
  { text: 'Exhibitions',   url: '#' },
  { text: 'Help',          url: '/help' },
  { text: 'Good hands',    url: '#' },
  { text: 'Competitions',  url: '#' },
  { text: 'Rules',         url: '/rules' },
  { text: 'Experts',       url: '#' },
  { text: 'Charity',       url: '/charity' },
  { text: 'Team',          url: '/team' }
].each_with_index do |v, i|
    Menu.create( kind: Menu.kinds[:foot], order_num: (i+1)*10, text: v[:text], url: v[:url]);
end

[
  { icon: 'vk' },
  { icon: 'at' },
  { icon: 'twitter' },
  { icon: 'facebook'  },
  { icon: 'feed'  },
  { icon: 'odnoklassniki' }
].each_with_index do |v, i|
    Menu.create( kind: Menu.kinds[:social], order_num: (i+1)*10, icon: v[:icon] );
end

[
  { class_name: 'yobrand' }
].each_with_index do |v, i|
    Menu.create( kind: Menu.kinds[:partner], order_num: (i+1)*10, class_name: v[:class_name] );
end
