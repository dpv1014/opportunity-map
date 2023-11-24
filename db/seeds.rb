if User.count.zero?
  User.create!(
    email: "fernando@gmail.com",
    password: "123456",
    name: "Fernando Santa",
    role: :admin)
end
