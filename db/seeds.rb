# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Populate standard roles
Role.delete_all

Role.create! description: "site_admin"
Role.create! description: "tenant_admin"
Role.create! description: "author"

User.create! name: "sa",
  password: "f",
  password_confirmation: "f",
  tenant_id: 1, # this is not used for site admins
  role_id: ROLE_ADMIN

User.create! name: "ta",
  password: "f",
  password_confirmation: "f",
  tenant_id: 1,
  role_id: ROLE_TENANT_ADMIN

User.create! name: "ff",
  password: "f",
  password_confirmation: "f",
  tenant_id: 1,
  role_id: ROLE_AUTHOR

# Set seed value; Faker, like Ruby's built-in Random#rand, depends on the state
# of the system PRNG.
srand 12345

FAKE_TENANTS_CNT = 5
FAKE_USERS_CNT = 30
FAKE_POSTS_CNT = 1000

FAKE_TENANTS_CNT.times do |n|
  Tenant.create!\
    name: Faker::Commerce.department(1)
end

print "Creating users..."

# Create fake users; there are 3 classes of users: site admins (who have power
# over everyone else), tenant admins (who have power only over the regular users
# that are from their own tenancy), and regular users (who have a tenant_id, and
# whose content are always associated with this tenant). The tenant_id only matters for tenant admins and regular users (site admins overrule all tenants, so it does not make sense for them to have a tenant id).
FAKE_USERS_CNT.times do
  name = Faker::Internet.user_name
  password = "f"
  reg_user = (rand 10) > 0
  User.create!\
    name: name,
    password: password,
    password_confirmation: password,
    tenant_id: 1 + (rand FAKE_TENANTS_CNT),
    role_id: reg_user ? ROLE_AUTHOR : ROLE_TENANT_ADMIN
end

puts "done"
puts "Creating posts..."

# Select fake (regular, non-admin) users at random, and have them create posts.
posts_total = FAKE_POSTS_CNT
posts_cnt_total = 0
posts_checkpoint = 0
denom = 10
while posts_total > 0 do
  # Add 2, to skip over site_admin and 'ff'; we add 1 to `rand FAKE_USERS_CNT`
  # b/c SQL rows start by counting at 1
  user_id = 2 + ((rand FAKE_USERS_CNT) + 1)
  # Choose the number of posts this person will create at this instance. If we
  # just do FAKE_POSTS_CNT / FAKE_USERS_CNT, this number is the average number
  # of posts per user, if every user posted the same number of posts. We divide
  # this by 4 here, just so that the posts are spread across more users
  # (essentially, this reduces the chance that we will end up with many users
  # who have no posts at all).
  post_cnt = rand (FAKE_POSTS_CNT / FAKE_USERS_CNT / 2)
  post_cnt.times do
    paragraphs_cnt = 1 + (rand 15)
    tc = Faker::Time.between(600.days.ago, Time.now)
    tu = tc
    if rand(2) == 0
      tu = Faker::Time.backward(600)
    end
    Post.create!\
      user_id: user_id,
      tenant_id: User.find(user_id).tenant_id,
      title: Faker::Lorem.sentence[0..254],
      body: Faker::Lorem.paragraphs(paragraphs_cnt).join("\n\n"),
      published: rand(2) == 0,
      created_at: tc,
      updated_at: tu
  end
  posts_total -= post_cnt
  posts_cnt_total += post_cnt

  checkpoint_maybe = posts_cnt_total / (FAKE_POSTS_CNT / denom)
  if checkpoint_maybe > posts_checkpoint
    posts_checkpoint = checkpoint_maybe
    puts "#{checkpoint_maybe * denom}% complete"
  end
end

print "done"
