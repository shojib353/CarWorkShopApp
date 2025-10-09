# CarWorkShop App - Workflow Diagram

## Overview
The CarWorkShop App is a Flutter-based mobile application for managing car service bookings. It uses Firebase for authentication and data storage, with role-based access control for Admin and Mechanic users.

---

## 1. Application Entry Flow

```
┌─────────────────┐
│   App Start     │
│   (main.dart)   │
└────────┬────────┘
         │
         ▼
┌─────────────────────┐
│ Firebase Init       │
│ (Firebase.init)     │
└──────────┬──────────┘
           │
           ▼
┌─────────────────────┐
│  CarServingApp      │
│  (MaterialApp)      │
└──────────┬──────────┘
           │
           ▼
┌─────────────────────┐
│   SigninScreen      │
│  (Entry Point)      │
└─────────────────────┘
```

---

## 2. Authentication Workflow

### 2.1 Sign In Flow

```
┌──────────────────┐
│  SigninScreen    │
└────────┬─────────┘
         │
         ├─── User enters: Email, Password, Role (Admin/Mechanic)
         │
         ▼
┌──────────────────────────────┐
│  Firebase Authentication     │
│  (signInWithEmailAndPassword)│
└────────┬─────────────────────┘
         │
         ├─── Success ──────────────┐
         │                          │
         ▼                          ▼
┌────────────────────┐    ┌─────────────────────┐
│  Fetch User from   │    │  Authentication     │
│  Firestore DB      │    │  Failed - Show      │
│  (users collection)│    │  Error Dialog       │
└─────────┬──────────┘    └─────────────────────┘
          │
          ├─── Verify Role matches selected role
          │
          ▼
┌─────────────────────┐
│   Navigate to       │
│   MainPage          │
│   (main_screen)     │
└─────────────────────┘
```

### 2.2 Sign Up Flow

```
┌──────────────────┐
│  SignupScreen    │
└────────┬─────────┘
         │
         ├─── User enters: Name, Email, Phone, Password, Role
         │
         ▼
┌──────────────────────────────┐
│  Firebase Authentication     │
│  (createUserWithEmailAndPass)│
└────────┬─────────────────────┘
         │
         ├─── Success ──────────────┐
         │                          │
         ▼                          ▼
┌────────────────────┐    ┌─────────────────────┐
│  Store User Data   │    │  Signup Failed      │
│  in Firestore      │    │  Show Error Dialog  │
│  (users collection)│    └─────────────────────┘
│  - name            │
│  - email           │
│  - phone           │
│  - role            │
│  - createdAt       │
└─────────┬──────────┘
          │
          ▼
┌─────────────────────┐
│   Navigate to       │
│   SigninScreen      │
└─────────────────────┘
```

### 2.3 Password Reset Flow

```
┌──────────────────┐
│  SigninScreen    │
│  (Forgot Pass?)  │
└────────┬─────────┘
         │
         ├─── User enters Email
         │
         ▼
┌──────────────────────────────┐
│  Firebase Auth               │
│  (sendPasswordResetEmail)    │
└────────┬─────────────────────┘
         │
         ├─── Email sent ────────┐
         │                       │
         ▼                       ▼
┌────────────────────┐  ┌────────────────┐
│  Show Success      │  │  Show Error    │
│  Dialog            │  │  Dialog        │
└────────────────────┘  └────────────────┘
```

---

## 3. Main Application Flow

### 3.1 MainPage (main_screen.dart)

```
┌──────────────────────┐
│    MainPage          │
│    (StatefulWidget)  │
└──────────┬───────────┘
           │
           ├─── initState: Fetch User Data
           │
           ▼
┌──────────────────────────────┐
│  Firestore Query             │
│  db.collection('users')      │
│      .doc(userId).get()      │
└──────────┬───────────────────┘
           │
           ├─── Extract: userName, role
           │
           ▼
┌──────────────────────────────┐
│  Show Loading Indicator      │
│  while fetching data         │
└──────────┬───────────────────┘
           │
           ▼
┌──────────────────────────────┐
│  Build UI with:              │
│  - AppDrawer (navigation)    │
│  - AppBar with title         │
│  - Add button (Admin only)   │
│  - HomeScreen (body)         │
└──────────────────────────────┘
```

---

## 4. Role-Based Screen Flow

### 4.1 Admin View

```
┌──────────────────────┐
│    MainPage          │
│    (role: Admin)     │
└──────────┬───────────┘
           │
           ▼
┌──────────────────────────────┐
│  HomeScreen                  │
│  - Fetch all bookings        │
│  - Show ListView             │
└──────────┬───────────────────┘
           │
           ├─── Display booking list with:
           │    - Customer name
           │    - Assigned mechanic
           │    - Start/End dates
           │    - Vehicle plate
           │
           ├─── AppBar "+" button
           │
           ▼
┌──────────────────────────────┐
│  BookingScreen               │
│  (Create new booking)        │
└──────────────────────────────┘
```

### 4.2 Mechanic View

```
┌──────────────────────┐
│    MainPage          │
│    (role: Mechanic)  │
└──────────┬───────────┘
           │
           ▼
┌──────────────────────────────┐
│  HomeScreen                  │
│  → CalenderScreen            │
│  - Fetch mechanic's bookings │
│  - Show Calendar View        │
└──────────┬───────────────────┘
           │
           ├─── Query: bookings where mechanic = userName
           │
           ▼
┌──────────────────────────────┐
│  SfCalendar                  │
│  (Syncfusion Calendar)       │
│  - Month view                │
│  - Display appointments      │
└──────────────────────────────┘
```

---

## 5. Booking Creation Workflow (Admin Only)

```
┌──────────────────────────────┐
│  BookingScreen               │
│  (Admin access only)         │
└──────────┬───────────────────┘
           │
           ├─── initState: Fetch mechanics
           │
           ▼
┌──────────────────────────────┐
│  Firestore Query             │
│  db.collection('users')      │
│    .where('role',            │
│        isEqualTo: 'Mechanic')│
└──────────┬───────────────────┘
           │
           ├─── Populate dropdown with mechanic names
           │
           ▼
┌──────────────────────────────┐
│  Form Fields:                │
│                              │
│  Customer Details:           │
│  - Name                      │
│  - Phone                     │
│  - Email                     │
│                              │
│  Vehicle Details:            │
│  - Make                      │
│  - Model                     │
│  - Year                      │
│  - Plate                     │
│                              │
│  Booking Details:            │
│  - Title                     │
│  - Start Date                │
│  - End Date                  │
│  - Assign Mechanic (dropdown)│
└──────────┬───────────────────┘
           │
           ├─── User fills form & submits
           │
           ▼
┌──────────────────────────────┐
│  Form Validation             │
└──────────┬───────────────────┘
           │
           ├─── Valid ────────────┐
           │                      │
           ▼                      ▼
┌──────────────────────┐  ┌────────────────┐
│  Create Booking Data │  │  Show          │
│  Object:             │  │  Validation    │
│  {                   │  │  Errors        │
│    name,             │  └────────────────┘
│    phone,            │
│    email,            │
│    make,             │
│    model,            │
│    year,             │
│    plate,            │
│    title,            │
│    start,            │
│    end,              │
│    mechanic          │
│  }                   │
└──────────┬───────────┘
           │
           ▼
┌──────────────────────────────┐
│  Firestore Write             │
│  db.collection('booking')    │
│    .add(bookingData)         │
└──────────┬───────────────────┘
           │
           ├─── Success ──────────┐
           │                      │
           ▼                      ▼
┌──────────────────────┐  ┌────────────────┐
│  Show Success        │  │  Show Error    │
│  SnackBar            │  │  SnackBar      │
│  "Booking Successful"│  │  "Booking      │
└──────────────────────┘  │   Failed"      │
                          └────────────────┘
```

---

## 6. Data Models

### 6.1 User Model (Firestore: 'users' collection)

```
{
  "name": "String",
  "email": "String",
  "phone": "String",
  "role": "String",  // "Admin" or "Mechanic"
  "createdAt": "Timestamp"
}
```

### 6.2 Booking Model (Firestore: 'booking' collection)

```
{
  "name": "String",      // Customer name
  "phone": "String",     // Customer phone
  "email": "String",     // Customer email
  "make": "String",      // Vehicle make
  "model": "String",     // Vehicle model
  "year": "String",      // Vehicle year
  "plate": "String",     // Vehicle plate number
  "title": "String",     // Booking title
  "start": "String",     // Start date
  "end": "String",       // End date
  "mechanic": "String"   // Assigned mechanic name
}
```

---

## 7. Navigation Drawer Workflow

```
┌──────────────────────────────┐
│  AppDrawer                   │
│  (Common for all screens)    │
└──────────┬───────────────────┘
           │
           ├─── Display user info:
           │    - Avatar
           │    - User name
           │    - User role
           │
           ├─── Menu Options:
           │
           ├─── Logout
           │
           ▼
┌──────────────────────────────┐
│  Firebase Sign Out           │
│  Navigate to SigninScreen    │
└──────────────────────────────┘
```

---

## 8. Complete User Journey Diagrams

### 8.1 Admin User Journey

```
Start
  │
  ▼
Sign In (as Admin)
  │
  ▼
MainPage
  │
  ├─→ View All Bookings (HomeScreen)
  │   │
  │   ├─→ See booking details
  │   └─→ Monitor all mechanics' work
  │
  ├─→ Create New Booking (tap + button)
  │   │
  │   ├─→ BookingScreen
  │   ├─→ Fill customer details
  │   ├─→ Fill vehicle details
  │   ├─→ Fill booking details
  │   ├─→ Select mechanic from dropdown
  │   ├─→ Submit booking
  │   └─→ Return to MainPage
  │
  └─→ Logout (via drawer)
      └─→ Return to SigninScreen
```

### 8.2 Mechanic User Journey

```
Start
  │
  ▼
Sign In (as Mechanic)
  │
  ▼
MainPage
  │
  ├─→ View Assigned Bookings (CalenderScreen)
  │   │
  │   ├─→ See calendar view
  │   ├─→ View appointments for the month
  │   └─→ See booking details
  │
  └─→ Logout (via drawer)
      └─→ Return to SigninScreen
```

---

## 9. Firebase Integration Architecture

```
┌─────────────────────────────────────────────┐
│          Flutter Application                │
│                                             │
│  ┌──────────────┐    ┌─────────────────┐   │
│  │ Presentation │    │   Business      │   │
│  │   Layer      │◄──►│   Logic         │   │
│  │  (Screens)   │    │   Layer         │   │
│  └──────────────┘    └────────┬────────┘   │
│                               │             │
└───────────────────────────────┼─────────────┘
                                │
                                ▼
┌─────────────────────────────────────────────┐
│              Firebase Services              │
│                                             │
│  ┌──────────────────┐  ┌─────────────────┐ │
│  │  Authentication  │  │   Firestore     │ │
│  │  - Sign In       │  │   Database      │ │
│  │  - Sign Up       │  │   - users       │ │
│  │  - Password      │  │   - booking     │ │
│  │    Reset         │  │                 │ │
│  └──────────────────┘  └─────────────────┘ │
└─────────────────────────────────────────────┘
```

---

## 10. Screen Flow Diagram

```
┌─────────────────┐
│  SigninScreen   │◄──────────────────────┐
└────────┬────────┘                       │
         │                                │
         ├─→ Sign Up ──┐                  │
         │             │                  │
         │             ▼                  │
         │      ┌─────────────────┐      │
         │      │  SignupScreen   │      │
         │      └────────┬────────┘      │
         │               │               │
         │               └─ After signup │
         │                               │
         ├─→ Sign In (Admin) ────────────┼───┐
         │                               │   │
         └─→ Sign In (Mechanic) ─────────┼───┤
                                         │   │
                                         │   ▼
                              ┌──────────┴────────────┐
                              │      MainPage         │
                              │   (main_screen)       │
                              └──────────┬────────────┘
                                         │
                              ┌──────────┴────────────┐
                              │                       │
                              ▼                       ▼
                    ┌──────────────────┐   ┌──────────────────┐
                    │   HomeScreen     │   │   HomeScreen     │
                    │   (Admin View)   │   │ (Mechanic View)  │
                    │  - ListView of   │   │  → CalenderScreen│
                    │    all bookings  │   │  - Calendar View │
                    └────────┬─────────┘   └──────────────────┘
                             │
                             │
                    ┌────────▼──────────┐
                    │  BookingScreen    │
                    │  (Create Booking) │
                    └───────────────────┘
```

---

## 11. Key Features Summary

### Authentication
- Firebase Authentication with Email/Password
- Role-based user registration (Admin/Mechanic)
- Password reset functionality
- User data stored in Firestore

### Admin Features
- View all bookings in a list
- Create new bookings
- Assign mechanics to bookings
- Manage customer and vehicle details

### Mechanic Features
- View assigned bookings in calendar format
- Track appointments by month
- View booking details

### Data Management
- Firebase Firestore for data storage
- Real-time data synchronization
- Two main collections: 'users' and 'booking'

### UI Components
- Material Design with custom theme
- Responsive forms with validation
- Navigation drawer for menu
- Role-based UI rendering
- Loading indicators for async operations

---

## 12. Technology Stack

- **Frontend**: Flutter (Dart)
- **Backend**: Firebase
  - Firebase Authentication
  - Cloud Firestore
  - Firebase Storage
- **UI Library**: Material Design
- **Calendar**: Syncfusion Flutter Calendar
- **State Management**: StatefulWidget (setState)

---

## Notes

1. The application enforces role-based access at the UI level
2. Admin users cannot see the calendar view (only mechanics can)
3. Mechanics cannot create bookings (only admins can)
4. All data is synchronized through Firebase Firestore
5. The app requires internet connectivity for all operations
6. User sessions persist until explicit logout
