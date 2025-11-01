module todo_addr::todo_list {
    use std::string::String;
    use std::signer;
    use std::vector;

    // Struct to represent a single task
    struct Task has store, drop, copy {
        id: u64,
        content: String,
        completed: bool,
    }

    // Resource to store all tasks for a user
    struct TodoList has key {
        tasks: vector<Task>,
        task_counter: u64,
    }

    // Initialize the TodoList for a user
    public entry fun create_list(account: &signer) {
        let todo_list = TodoList {
            tasks: vector::empty<Task>(),
            task_counter: 0,
        };
        move_to(account, todo_list);
    }

    // Add a new task
    public entry fun create_task(account: &signer, content: String) acquires TodoList {
        let signer_address = signer::address_of(account);
        
        // Initialize list if it doesn't exist
        if (!exists<TodoList>(signer_address)) {
            create_list(account);
        };

        let todo_list = borrow_global_mut<TodoList>(signer_address);
        let task_id = todo_list.task_counter;
        
        let new_task = Task {
            id: task_id,
            content,
            completed: false,
        };
        
        vector::push_back(&mut todo_list.tasks, new_task);
        todo_list.task_counter = task_id + 1;
    }

    // Mark a task as completed
    public entry fun complete_task(account: &signer, task_id: u64) acquires TodoList {
        let signer_address = signer::address_of(account);
        let todo_list = borrow_global_mut<TodoList>(signer_address);
        
        let tasks_len = vector::length(&todo_list.tasks);
        let i = 0;
        while (i < tasks_len) {
            let task = vector::borrow_mut(&mut todo_list.tasks, i);
            if (task.id == task_id) {
                task.completed = true;
                break
            };
            i = i + 1;
        };
    }

    // View function to get all tasks
    #[view]
    public fun get_tasks(account_addr: address): vector<Task> acquires TodoList {
        if (!exists<TodoList>(account_addr)) {
            return vector::empty<Task>()
        };
        
        let todo_list = borrow_global<TodoList>(account_addr);
        todo_list.tasks
    }

    // View function to get task count
    #[view]
    public fun get_task_count(account_addr: address): u64 acquires TodoList {
        if (!exists<TodoList>(account_addr)) {
            return 0
        };
        
        let todo_list = borrow_global<TodoList>(account_addr);
        todo_list.task_counter
    }
}