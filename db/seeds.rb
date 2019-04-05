puts 'Destroying Packs'
Pack.destroy_all
puts 'Destroying Users'
User.destroy_all
puts 'Done'

puts 'Creatin Users'
User.create(email: 'romain@drm.com', password: 'mdpmdp', username: 'Zz', admin: true, remote_photo_url: 'http://imgup.motion-twin.com/twinoid/6/0/7e36a288_356665.jpg')
User.create(email: 'pierre@drm.com', password: 'mdpmdp', username: 'Potin', admin: false, remote_photo_url: 'https://i1.sndcdn.com/avatars-000322991231-qsaa9t-t500x500.jpg')

puts 'Creating Packs'
Pack.create(title: 'Uk Drill', description: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit.', price: 10, remote_photo_url: 'https://splice-res.cloudinary.com/image/upload/f_auto,q_auto,w_auto/c_limit,w_450/v1522682641/jlagncnlubq4rhb6v4ot.jpg')
Pack.create(title: 'Deep Trap', description: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit.', price: 10, remote_photo_url: 'https://splice-res.cloudinary.com/image/upload/f_auto,q_auto,w_auto/c_limit,w_450/v1496700105/vogsv8zregux1gmpeqvm.jpg')
Pack.create(title: 'Back to the 80\'s', description: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit.', price: 10, remote_photo_url: 'https://splice-res.cloudinary.com/image/upload/f_auto,q_auto,w_auto/c_limit,w_450/v1458663051/n6p9f8ijdroxxby4gtxl.jpg')
Pack.create(title: 'Graves', description: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit.', price: 10, remote_photo_url: 'https://splice-res.cloudinary.com/image/upload/f_auto,q_auto,w_auto/c_limit,w_450/v1496945018/1496945017.jpg')
Pack.create(title: 'Dirty Tech House', description: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit.', price: 10, remote_photo_url: 'https://www.loopmasters.com/system/products/covers/000/005/568/original/DTH-Cover.jpg?1478785963')
Pack.create(title: 'Black Skorown', description: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit.', price: 10, remote_photo_url: 'https://splice-res.cloudinary.com/image/upload/f_auto,q_auto,w_auto/c_limit,w_450/v1495813843/1495813755.jpg')
Pack.create(title: 'The Sound of Dirt Hop', description: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit.', price: 10, remote_photo_url: 'https://cdn.rekkerd.org/wp-content/uploads/2017/04/Splice-Sounds-Champagne-Drip-700x700.jpg')
Pack.create(title: 'Sakima', description: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit.', price: 10, remote_photo_url: 'https://cdn.rekkerd.org/wp-content/uploads/2017/09/Splice-Sounds-SAKIMA-Blue-Monday-Vocal-Sample-Pack.jpg')
Pack.create(title: 'Sad Neon', description: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit.', price: 10, remote_photo_url: 'https://www.noizefield.com/wp-content/uploads/2019/01/ecfd04ae2262955958877d1bb5b93cc8.jpeg')
Pack.create(title: 'Nicci Bounce', description: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit.', price: 10, remote_photo_url: 'https://www.noizefield.com/wp-content/uploads/2018/12/chromonicci-pack.jpg')

puts 'All Done'
