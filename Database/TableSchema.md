# Task Manager Table Schema

## Core tables

### Roles

| Column | Type | Key | Notes |
|---|---|---|---|
| RoleId | INT | PK | Unique role identifier |
| RoleName | VARCHAR(50) |  | Role name such as Admin or User |

### Users

| Column | Type | Key | Notes |
|---|---|---|---|
| UserId | INT | PK | Unique user identifier |
| FirstName | VARCHAR(50) |  | User first name |
| LastName | VARCHAR(50) |  | User last name |
| Email | VARCHAR(100) | UQ | Unique email address |
| PhoneNumber | VARCHAR(20) |  | User contact number |
| OrganizationId | VARCHAR(100) |  | References `Organization(OrganizationId)` |
| ProfilePhoto | VARCHAR(255) |  | File path or URL for profile image |
| RoleId | INT | FK | References `Roles(RoleId)`|

### Organization

| Column | Type | Key | Notes |
|---|---|---|---|
| OrganizationId | INT | PK | Unique Organization identifier |
| OrganizationName | VARCHAR(50) |  | Organization Name such as Company Name or Organization Name |

### UserSecurity

| Column | Type | Key | Notes |
|---|---|---|---|
| UserId | INT | PK, FK | References `Users(UserId)`|
| PasswordHash | VARCHAR(255) |  | Hashed password |
| Salt | VARCHAR(255) |  | Password salt |
| IsFrozen | BIT |  | Indicates account lock status  |
| FreezeUntil | DATETIME |  | Lock end time if applicable  |

### Projects

| Column | Type | Key | Notes |
|---|---|---|---|
| ProjectId | INT | PK | Unique project identifier  |
| ProjectName | VARCHAR(100) |  | Project title  |
| StartingDate | DATE |  | Project start date  |
| EndingDate | DATE |  | Project end date  |
| Comment | VARCHAR(500) |  | Optional project comment  |
| StatusId | INT | FK | References `ProjectStatus(StatusId)` |
| CreatedAt | DATETIME |  | Record creation time  |
| CreatedBy | INT | FK | References `Users(UserId)`  |

### Tasks

| Column | Type | Key | Notes |
|---|---|---|---|
| TaskId | INT | PK | Unique task identifier  |
| ProjectId | INT | FK | References `Projects(ProjectId)`  |
| TaskName | VARCHAR(100) |  | Task name  |
| StartingDate | DATE |  | Task start date  |
| EndingDate | DATE |  | Task due date  |
| Comments | VARCHAR(500) |  | Task description or note  |
| PriorityId | INT | FK | References `TaskPriority(PriorityId)` |
| StatusId | INT | FK | References `TaskStatus(StatusId)` |
| CreatedAt | DATETIME |  | Record creation time, standardized from `CreateAt`  |
| CreatedBy | INT | FK | References `Users(UserId)`  |

## Relationship tables

### TaskParticipants

| Column | Type | Key | Notes |
|---|---|---|---|
| ParticipantId | INT | PK | Unique participation row identifier |
| TaskId | INT | FK | References `Tasks(TaskId)` |
| UserId | INT | FK | References `Users(UserId)`; normalized from ambiguous participant fielding in the ERD |
| Responsibility | VARCHAR(100) |  | Responsibility assigned to the participant |

### Attachments

| Column | Type | Key | Notes |
|---|---|---|---|
| AttachmentId | INT | PK | Unique attachment identifier |
| AttachedFile | VARCHAR(255) |  | File path or stored document name |

### TaskAttachments

| Column | Type | Key | Notes |
|---|---|---|---|
| TaskId | INT | PK, FK | References `Tasks(TaskId)` |
| AttachmentId | INT | PK, FK | References `Attachments(AttachmentId)` |

## To-do tables

### ToDoList

| Column | Type | Key | Notes |
|---|---|---|---|
| ToDoId | INT | PK | Unique to-do list identifier |
| ToDoName | VARCHAR(100) |  | To-do list title |
| Comment | VARCHAR(500) |  | Optional list note |
| StartingDate | DATE |  | Start date |
| EndingDate | DATE |  | End date |
| CreatedAt | DATETIME |  | Record creation time |
| CreatedBy | INT | FK | References `Users(UserId)` |

### ToDoItems

| Column | Type | Key | Notes |
|---|---|---|---|
| ItemId | INT | PK | Unique item identifier |
| ToDoId | INT | FK | References `ToDoList(ToDoId)` |
| ItemName | VARCHAR(100) |  | Item title |
| Comment | VARCHAR(500) |  | Optional item note |

## Activity and request tables

### LoginAttempts

| Column | Type | Key | Notes |
|---|---|---|---|
| AttemptId | INT | PK | Unique login attempt identifier |
| UserId | INT | FK | References `Users(UserId)` |
| AttemptedAt | DATETIME |  | Attempt time |
| SuccessStatus | BIT |  | Whether login succeeded |

### DurationExtensionRequests

| Column | Type | Key | Notes |
|---|---|---|---|
| RequestId | INT | PK | Unique extension request identifier |
| TaskId | INT | FK | References `Tasks(TaskId)` |
| RequestedBy | INT | FK | References `Users(UserId)`; standardized from `RequestBy` and `Requested_by` |
| NewEndingDate | DATE |  | Proposed new due date |
| Reason | VARCHAR(500) |  | Reason for extension |
| StatusId | INT | FK | References `RequestStatus(StatusId)` |
| RequestedAt | DATETIME |  | Request creation time  |

### Notifications

| Column | Type | Key | Notes |
|---|---|---|---|
| NotificationId | INT | PK | Unique notification identifier |
| TaskId | INT | FK | References `Tasks(TaskId)` |
| MessageTemplate | VARCHAR(500) |  | Notification message text |
| ReminderDaysBefore | INT |  | Days before due date to remind |

## Lookup tables

### TaskPriority

| Column | Type | Key | Notes |
|---|---|---|---|
| PriorityId | INT | PK | Unique priority identifier |
| PriorityName | VARCHAR(50) |  | Example values: Low, Medium, High |

### TaskStatus

| Column | Type | Key | Notes |
|---|---|---|---|
| StatusId | INT | PK | Unique task status identifier |
| StatusName | VARCHAR(50) |  | Example values: Pending, In Progress, Completed |

### ProjectStatus

| Column | Type | Key | Notes |
|---|---|---|---|
| StatusId | INT | PK | Unique project status identifier |
| StatusName | VARCHAR(50) |  | Example values: Planned, Active, Closed |

### RequestStatus

| Column | Type | Key | Notes |
|---|---|---|---|
| StatusId | INT | PK | Unique request status identifier |
| StatusName | VARCHAR(50) |  | Example values: Pending, Approved, Rejected |

## Relationship summary

| Parent Table | Child Table | Relationship |
|---|---|---|
| Roles | Users | One role to many users |
| Users | Projects | One user creates many projects |
| Users | Tasks | One user creates many tasks |
| Projects | Tasks | One project has many tasks |
| Tasks | TaskParticipants | One task has many participants |
| Users | TaskParticipants | One user can join many task assignments |
| Tasks | TaskAttachments | One task can map to many attachments |
| Attachments | TaskAttachments | One attachment can map through the bridge table |
| ToDoList | ToDoItems | One list has many items |
| Users | LoginAttempts | One user can have many login attempts |
| Tasks | DurationExtensionRequests | One task can have many extension requests |
| Users | DurationExtensionRequests | One user can request many extensions |
| Tasks | Notifications | One task can have many notifications |

