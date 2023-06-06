#[contract]
mod LocalVariablesExample {
    #[view]
    fn do_something(value: u32) -> u32 {
        // Declare a new local variable in the function
        let increment = 10;

        {
            // The scope of a code block allows for local variable declaration
            let sum = value + increment;
            sum
        }
    }
}
