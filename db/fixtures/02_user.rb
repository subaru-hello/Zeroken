
    User.seed do |s|
        s.id = 1
        s.email = 'test@examle.com'
        s.nickname = 'テス太郎'
        s.password = 'aaaaaaa'
        s.password_confirmation = 'aaaaaaa'
        s.avatar = Rails.root.join("db/fixtures/images/sample.png").open
        s.role = 0
        end
    
    