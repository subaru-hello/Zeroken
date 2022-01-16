    User.seed do |s|
        s.id = 1
        s.email = 'test_1@example.com'
        s.nickname = 'テスト太郎'
        s.password = 'aaaaaaa'
        s.password_confirmation = 'aaaaaaa'
        s.avatar = Rails.root.join("db/fixtures/images/sample.png").open
        s.role = 0
        end
    User.seed do |s|
        s.id = 2
        s.email = 'test_2@example.com'
        s.nickname = 'テスト花子'
        s.password = 'aaaaaaa'
        s.password_confirmation = 'aaaaaaa'
        s.avatar = Rails.root.join("db/fixtures/images/sample.png").open
        s.role = 1
        end