from robot.api.deco import library, keyword
from robot.api import logger

@library
class Calculator:
    def __init__(self):
        self.state = "initialized"
        self.a = 0
        self.b = 0
        self.result = 0

    @keyword("Start Calculator")
    def start_calculator(self):
        self.state = "started"
        logger.info("Calculator started successfully.")

    @keyword("Stop Calculator")
    def stop_calculator(self):
        self.state = "stopped"
        logger.info("Calculator stopped successfully.")

    @keyword("Get State")
    def get_state(self):
        return self.state
    
    @keyword("Set A")
    def set_a(self, value):
        self.a = value
        logger.info(f"Value of A set to {self.a}")
    
    @keyword("Set B")
    def set_b(self, value):
        self.b = value
        logger.info(f"Value of B set to {self.b}")

    @keyword("Get Result")
    def get_result(self):
        return float(self.result)
    
    @keyword("Add")
    def add(self):
        self.result = float(self.a) + float(self.b)

    @keyword("Subtract")
    def substract(self):
        self.result = float(self.a) - float(self.b)

    @keyword("Multiply")
    def multiply(self):
        self.result = float(self.a) * float(self.b)

    @keyword("Divide")
    def divide(self):
        if float(self.b) == 0:
            logger.error("Attempted to divide by zero.")
            raise ValueError("Division by zero is not allowed.")
        self.result = float(self.a) / float(self.b)