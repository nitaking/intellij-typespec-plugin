// Test file for Go to Declaration
// Cmd+Click / Ctrl+Click on each symbol to verify navigation to its declaration

namespace Navigation;

model Address {
  street: string;
  city: string;
  country: string;
}

model User {
  id: int32;
  name: string;
  email: string;
  address: Address; // verify jump to Address
}

model Order {
  id: int32;
  user: User;       // verify jump to User
  items: OrderItem[];
  total: float32;
}

model OrderItem {
  productId: int32;
  quantity: int32;
  price: float32;
}

alias UserId = int32;   // verify jump to alias

model AdminUser extends User {  // verify jump via extends
  role: "admin" | "superadmin";
}
