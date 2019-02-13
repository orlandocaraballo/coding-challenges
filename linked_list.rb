# //In computer science, a linked list is a linear collection of data elements, called nodes, each pointing to the next node by means of a pointer. It is a data structure consisting of a group of nodes which together represent a sequence. Under the simplest form, each node is composed of data and a reference (in other words, a link) to the next node in the sequence. This structure allows for efficient insertion or removal of elements from any position in the sequence during iteration. More complex variants add additional links, allowing efficient insertion or removal from arbitrary element references.
# 
# //CHALLENGE:
# // Implement your own Sorted Linked List of Users.
# 
# // The User class is a class that holds the User's name and age.
# 
# //  The list should be sorted in ascending order based on their age.
# 
# //  The list should have: 
# //      - `first()` method that returns the first (youngest) User
# //      - `add(User user)` method that adds a User
# //      - `printAllUsers()` method that prints all users from the list to the console

# define our User class with name and age instance variables
class User
  attr_reader :name, :age
  
  def initialize(name, age)
    @name, @age = name, age
  end

  # we define this so that puts can utilize this method
  #   when choosing how to display a user
  def to_s
    "{ name: #{ @name }, age: #{ @age } }"
  end
end

# define our Node class with value and next instance variables
class Node
  attr_accessor :next, :value
  
  def initialize(value)
    @value = value
    @next = nil
  end
end

# define our LinkedList class with an empty head by default
class LinkedList
  def initialize
    @head = nil
  end
  
  # Complexity:
  #   worst - O(1)
  #   average - O(1)
  #   best - O(1)
  def first
    # return value if head node is set
    if !@head.nil?
      @head.value
    else
      # otherwise raise an exception
      raise "List is empty"
    end
  end
  
  # Complexity:
  #   worst - O(n)
  #   average - O(n)
  #   best - O(1)
  def add(user)  
    # when linked list is empty
    if @head.nil?
      # create a new node and set it to the head
      @head = Node.new(user)
      return 
    end

    # check if age is less than the head user age of the linked list
    if @head.value.age > user.age
      # if so then do the following:
        #   - store original head reference in originalHead
        #   - create a new node
        #   - set the new node's next reference to the original head reference
        #   - set the head of the list to this new node
        #   - return from the method

      # we are inserting this user to the beginning of the list
      originalHead = @head
      newNode = Node.new(user)
      newNode.next = originalHead
      @head = newNode
      return
    end

    # all other circumstances follow from here

    # we store the head initially as priorNode
    #   and the next node as currentNode
    priorNode = @head
    currentNode = @head.next

    # start looping until currentNode is nil
    #   under the circumstance where the linked list is of size 1,
    #   the if statement here will skip looping and jump to the bottom
    #   where we assume this user will be inserted into the end of the list
    while currentNode
      # check if user's age is less than the age of the currentNode's user age
      if currentNode.value.age > user.age
        # if so then do the following:
        #   - create a new node
        #   - set the new node's next reference to the currentNode we are looping on
        #   - set the priorNode next reference to this newly created node
        #   - return from the method

        # in essence we are inserting this new user object to be in between
        #   the priorNode and the currentNode we are looping on
        priorNode.next = Node.new(user)
        priorNode.next.next = currentNode
        return
      end

      # set priorNode to currentNode we are looping on
      priorNode = currentNode

      # set currentNode to the next node in the linked list
      currentNode = currentNode.next
    end

    # at this point we've looped to the end of the list
    #   therefore we can assume the node belongs at the end of list
    priorNode.next = Node.new(user)
  end
  
  # Complexity:
  #   always - O(n)
  def printAllUsers
    currentNode = @head
    
    # loop through every element
    while currentNode
      # display the currentNode value which uses the user.to_s
      #   method behind the scenes to handle the printing logic
      puts currentNode.value
      currentNode = currentNode.next
    end
  end
end

# create our linked list object
linkedList = LinkedList.new

# let's test the edge case where we try grabbing 
#   the first value of linked list when list is empty
begin
  puts linkedList.first
rescue StandardError => error
  puts error
end

# add some users to the linked list
linkedList.add(User.new("orlando", 35))
linkedList.add(User.new("denisse", 20))
linkedList.add(User.new("patrisha", 13))
linkedList.add(User.new("jenny", -9001))
linkedList.add(User.new("josefina", 1000))
linkedList.add(User.new("clark", -1))
linkedList.add(User.new("alex", 100))
linkedList.add(User.new("frank", 3))

# display all users
linkedList.printAllUsers

# display front of list
puts "front of list is -> #{ linkedList.first }"
