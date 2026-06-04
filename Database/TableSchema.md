# Task Manager Table Schema

## Core tables

### Roles

| Column | Type | Key | Notes |
|---|---|---|---|
| RoleId | INT | PK | Unique role identifier |
| RoleName | NVARCHAR(50) |  | Role name such as Admin or User |

### Users

| Column | Type | Key | Notes |
|---|---|---|---|
| UserId | INT | PK | Unique user identifier |
| FirstName | NVARCHAR(50) |  | User first name |
| LastName | NVARCHAR(50) |  | User last name |
| Email | NVARCHAR(100) | UQ | Unique email address |
| PhoneNumber | NVARCHAR(20) |  | User contact number |
| OrganizationName | NVARCHAR(100) |  | Organization or company name |
| ProfilePhoto | NVARCHAR(255) |  | File path or URL for profile image |
| RoleId | INT | FK | References `Roles(RoleId)`|

### UserSecurity

| Column | Type | Key | Notes |
|---|---|---|---|
| UserId | INT | PK, FK | References `Users(UserId)`|
| PasswordHash | NVARCHAR(255) |  | Hashed password |
| Salt | NVARCHAR(255) |  | Password salt |
| IsFrozen | BIT |  | Indicates account lock status  |
| FreezeUntil | DATETIME |  | Lock end time if applicable  |

### Projects

| Column | Type | Key | Notes |
|---|---|---|---|
| ProjectId | INT | PK | Unique project identifier  |
| ProjectName | NVARCHAR(100) |  | Project title  |
| StartingDate | DATE |  | Project start date  |
| EndingDate | DATE |  | Project end date  |
| Comment | NVARCHAR(500) |  | Optional project comment  |
| StatusId | INT | FK | References `ProjectStatus(StatusId)` |
| CreatedAt | DATETIME |  | Record creation time  |
| CreatedBy | INT | FK | References `Users(UserId)`  |

### Tasks

| Column | Type | Key | Notes |
|---|---|---|---|
| TaskId | INT | PK | Unique task identifier  |
| ProjectId | INT | FK | References `Projects(ProjectId)`  |
| TaskName | NVARCHAR(100) |  | Task name  |
| StartingDate | DATE |  | Task start date  |
| EndingDate | DATE |  | Task due date  |
| Comments | NVARCHAR(500) |  | Task description or note  |
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
| Responsibility | NVARCHAR(100) |  | Responsibility assigned to the participant |

### Attachments

| Column | Type | Key | Notes |
|---|---|---|---|
| AttachmentId | INT | PK | Unique attachment identifier |
| AttachedFile | NVARCHAR(255) |  | File path or stored document name |

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
| ToDoName | NVARCHAR(100) |  | To-do list title |
| Comment | NVARCHAR(500) |  | Optional list note |
| StartingDate | DATE |  | Start date |
| EndingDate | DATE |  | End date |
| CreatedAt | DATETIME |  | Record creation time |
| CreatedBy | INT | FK | References `Users(UserId)` |

### ToDoItems

| Column | Type | Key | Notes |
|---|---|---|---|
| ItemId | INT | PK | Unique item identifier |
| ToDoId | INT | FK | References `ToDoList(ToDoId)` |
| ItemName | NVARCHAR(100) |  | Item title |
| Comment | NVARCHAR(500) |  | Optional item note |

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
| Reason | NVARCHAR(500) |  | Reason for extension |
| StatusId | INT | FK | References `RequestStatus(StatusId)` |
| RequestedAt | DATETIME |  | Request creation time  |

### Notifications

| Column | Type | Key | Notes |
|---|---|---|---|
| NotificationId | INT | PK | Unique notification identifier |
| TaskId | INT | FK | References `Tasks(TaskId)` |
| MessageTemplate | NVARCHAR(500) |  | Notification message text |
| ReminderDaysBefore | INT |  | Days before due date to remind |

## Lookup tables

### TaskPriority

| Column | Type | Key | Notes |
|---|---|---|---|
| PriorityId | INT | PK | Unique priority identifier |
| PriorityName | NVARCHAR(50) |  | Example values: Low, Medium, High |

### TaskStatus

| Column | Type | Key | Notes |
|---|---|---|---|
| StatusId | INT | PK | Unique task status identifier |
| StatusName | NVARCHAR(50) |  | Example values: Pending, In Progress, Completed |

### ProjectStatus

| Column | Type | Key | Notes |
|---|---|---|---|
| StatusId | INT | PK | Unique project status identifier |
| StatusName | NVARCHAR(50) |  | Example values: Planned, Active, Closed |

### RequestStatus

| Column | Type | Key | Notes |
|---|---|---|---|
| StatusId | INT | PK | Unique request status identifier |
| StatusName | NVARCHAR(50) |  | Example values: Pending, Approved, Rejected |

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

