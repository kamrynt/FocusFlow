# MobileAppDev
Original App Design Project
===

# FocusFlow

## Table of Contents

1. [Overview](#Overview)
2. [Product Spec](#Product-Spec)
3. [Wireframes](#Wireframes)
4. [Schema](#Schema)

## Overview

### Description

FocusFlow is a smart productivity tracking mobile application designed to help users manage their daily work and study routines. Leveraging the popular Pomodoro technique along with custom timer sessions, FocusFlow enables users to:
- **Plan & Track**: Create, edit, or delete daily goals and to-do items.

- **Focus Sessions**: Initiate focus sessions with adjustable timers (Pomodoro-style or custom duration), pause/resume functionality, and optional break intervals.

- **Session Logging**: Automatically record details about when, where, and for how long sessions occur.

- **Media & Location**: Upload workspace photos and note down session details, with automatic location logging using MapKit.

- **Motivation & Analytics**: Receive a daily motivational quote and observe productivity trends via session logs and a streak tracker.

The application integrates with Firebase for user authentication and data storage (Firestore), uses a REST API for dynamic content like quotes, and optionally employs Parse for enhanced media handling.

### App Evaluation

- **Category:** Productivity / Life-Management
- **Mobile:** Designed as a mobile-first app with potential web integration later.
- **Story:**  FocusFlow tells the story of a daily journey to improved focus and productivity. Users start their day by planning tasks, engaging in dedicated focus sessions, and reviewing their progress with visual location and session logs.
- **Market:** Targeted at students, remote workers, freelancers, and any professionals seeking to boost their daily productivity and form lasting focus habits.
- **Habit:** Designed for daily use with features that promote routine building (e.g., streak trackers and daily motivational quotes).
- **Scope:** Initially a narrow MVP focusing on core productivity features with scalability options into additional functionalities (e.g., enhanced analytics, integrations with other productivity tools).
## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

* User Authentication

        User can register an account via email/password authentication using Firebase Auth.

        User can log in and log out securely to access personalized data.

* Tasks & Goals Management

        User can create, view, edit, and delete daily tasks or goals to plan the day’s priorities.

* Focus Session Management

        User can start a focus session with a default Pomodoro duration (e.g., 25 minutes) or set a custom timer.

        User can pause, resume, and reset the timer during a focus session.

        On session completion, the app prompts the user to optionally upload a photo, add a note or mood, and automatically logs the session location using MapKit.

* Session Logging and Review

        User can view a scrollable log of past sessions that includes session dates, durations, photos, and personal notes.

* Mapping Productivity

        User can view their productive locations on a map where sessions have occurred, with pins that can be tapped to reveal session details.

**Optional Nice-to-have Stories**

* User can retrieve and view a daily motivational quote via a REST API.

* User can adjust settings such as dark mode, custom notification or reminder settings, and even set session-related goals or reminders.

* User can see a streak tracker on their profile that motivates daily app engagement.

* User can persist session and task data across devices for seamless continuity.

### 2. Screen Archetypes


- [ ] Onboarding / Login Screen
* Required User Feature: 

        User can sign in/sign up via Firebase Auth.

- [ ] Home (Today) Screen
* Features:

        Greeting message (e.g., “Hey [User] 👋, ready to focus?”)

        To-do list with the ability to add new tasks

        “Start Focus Session” button

        Daily motivational quote display from a REST API

- [ ] Focus Session Screen
* Features:

        Timer UI (default 25 minutes or custom session timer)

        Options to pause and reset the timer

        On completion: prompt to upload a photo, add session note or mood, and automatic location logging

- [ ] Session Log Screen
* Features:

        A scrollable list or card view showing previous sessions with details (date, duration, photo, note)

        Tap-to-expand functionality for more detailed session info

- [ ] Map View Screen
* Features:

        Interactive map (using MapKit) that pins productive locations

        Tappable pins showing session details like photo and notes

- [ ] Profile / Settings Screen
* Features:

        View user streaks and total session count

        Manage user settings (e.g., dark mode, notifications, sign out)

### 3. Navigation

**Tab Navigation** (Tab to Screen)


- [ ]  **Today** :
Displays the to-do list, daily greeting, and “Start Focus Session” button.

- [ ] **Sessions**:
Displays a list of past focus sessions, each with optional photos and notes.

- [ ] **Map**:
Shows a map interface with pinned productive locations.

- [ ] **Profile**:
Provides user settings, sign-out option, and a view of the productivity streak tracker.


**Flow Navigation** (Screen to Screen)

- [ ] [**Onboarding / Authentication**]
  * Leads to [**Today Screen**]
- [ ] [**Today Screen**]
  * Leads to [**Focus Session Screen**] 
- [ ] [**Focus Session Screen**]
  * Leads to [**Session Completion**] 
- [ ] [**Sessions Screen**]
  * Leads to [**Session Detail**] 
- [ ] [**Map Screen**]
  * Leads to [**Session Detail**]
- [ ] [**Profile Screen**]
  * Leads to [**Settings / Sign Out**]


## Wireframes
![Mobile App Group Project](https://hackmd.io/_uploads/SJIGxu4Ryl.png)



## Schema 


### Models

[User Model]
| Property | Type   | Description                                  |
|----------|--------|----------------------------------------------|
| user_id | String | unique id for the user post (default field)   |
| username | String | user's display name  |
| email | String | user's email address   |
| password | String | user's password for login authentication      |
| created_at | DateTime | timestamp of when user account was created   |
| settings | Object | user preferences  |

[Task Model]
| Property | Type   | Description                                  |
|----------|--------|----------------------------------------------|
| id | String | unique task identifier |
| title | String | title of task |
| isComplete | Boolean | indicate whether the task is completed  |
| password | String | user's password for login authentication      |
| created_at | DateTime | timestamp of when task was created   |
| user_id | String | FK reference to User model  |

[Session Model]
| Property | Type   | Description                                  |
|----------|--------|----------------------------------------------|
| id | String | session identifier  |
| user_id | String | FK reference to user model  |
| start_time | DateTime | when the session started   |
| end_time | DateTime | when the session ended      |
| duration | Int | timestamp of when user account was created   |
| photo_url | String | URL to the uploaded session photo  |
| note | String | user-provided note  |
| location_lat | Int| latitude for the session log  |
| location_long | Int | longitude for the session log  |
| created_at | DateTime | timestamp when the session log was created  |

### Networking

- **User Authentication & Registration**

* [POST] /users

       Used for creating a new user account via Firebase Auth (the authentication process is largely managed by Firebase SDKs).

* [POST] /login

        User login request using email/password credentials.

- **Task Management**

* [POST] /tasks

        Create a new task for the current user.

* [PUT] /tasks/{taskId}

        Update an existing task (e.g., mark complete, edit title).

* [DELETE] /tasks/{taskId}

        Delete a task.

- **Session Management**

* [GET] /sessions

        Retrieve a list of past focus sessions for the logged-in user.

* [POST] /sessions

        Log a new session when a focus session completes, including timer data, photo URL, note, and location data.

- **Daily Motivational Quote** 

* [GET] /daily-quote

        Retrieve a motivational quote of the day from an external REST API.

- **Media Upload**

* [POST] /upload

        Endpoint for uploading photos for sessions, optionally using Parse for media handling.
