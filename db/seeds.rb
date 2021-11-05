# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create!(
    email: 'test@example.com',
    nickname: 'テスト太郎',
    password: 'aaaaaa',
    password_confirmation: 'aaaaaa'
 )
Analyze.create!(
    total_points: 1,
    sake_strongness_types: 'strong',
    next_nomivation_types: 'tipsy'
 )