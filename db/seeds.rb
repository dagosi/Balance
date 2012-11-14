def create_users
  # Creates an admin.
  admin = User.create(email: 'admin@admin.com', password: 'admin1234', admin: true)

  if admin.errors.any?
    puts "There are errors on admin creation."
  else
    puts "Admin was created successfully."
  end
  
  # Creates a normal user.
  daniel = User.create(email: 'daniel@daniel.com', password: 'daniel1234')
  
  if daniel.errors.any?
    puts "There are errors on daniel creation."
  else
    puts "Daniel was created successfully."
  end
end      
     
# Creates several registers for both users.
def create_registers
  admin = User.first
  
  # January
  admin.registers.build(date: '2012-01-01', description: 'Rent', amount: 1000, 
                        balance_type: 'Outgoing')
  
  admin.registers.build(date: '2012-01-01', description: 'Gas', amount: 150, 
                        balance_type: 'Outgoing')

  admin.registers.build(date: '2012-01-01', description: 'Food', amount: 300, 
                        balance_type: 'Outgoing')
  
  admin.registers.build(date: '2012-01-01', description: 'Subway', amount: 100, 
                        balance_type: 'Outgoing')
  
  admin.registers.build(date: '2012-01-01', description: 'Income', amount: 3000, 
                        balance_type: 'Income')
  
  admin.registers.build(date: '2012-01-01', description: 'Page income', amount: 1000, 
                        balance_type: 'Income')  

  # February
  admin.registers.build(date: '2012-02-01', description: 'Rent', amount: 1500, 
                        balance_type: 'Outgoing')
  
  admin.registers.build(date: '2012-02-01', description: 'Gas', amount: 250, 
                        balance_type: 'Outgoing')

  admin.registers.build(date: '2012-02-01', description: 'Food', amount: 200, 
                        balance_type: 'Outgoing')
  
  admin.registers.build(date: '2012-02-01', description: 'Subway', amount: 140, 
                        balance_type: 'Outgoing')
  
  admin.registers.build(date: '2012-02-01', description: 'Income', amount: 3000, 
                        balance_type: 'Income')
  
  admin.registers.build(date: '2012-02-01', description: 'New dog!', amount: 1500, 
                        balance_type: 'Outgoing')  


end

create_users
create_registers
