# AppifyLab Assessment

## Implementations
- **Login Screen**:
  - Login according to Figma UI.
  - Save authorization token on the device to keep the user logged in.
- **Logout**:
  - Clear all session data and logout.
- **Dynamic Feed Fetching Mechanism**:
  - Capable of handling any changes dynamically.
  - User-friendly pagination handling by infinity scrolling. 
- **Feed Post**:
  - Show Like Count, Comment Count, Specific Reactions, and User Reaction Status.
  - Long press Reaction button to handle multiple types of reactions (Like, Love, Care, Angry, Sad).
  - Feed post background color is applied on posts that has background according to API Documentation.
  - Text color for the feed content will be dyanmic based on the background color of the post. Best contrast color will be picked as text color based on the background the post.
- **Comments**:
  - Show full names and profile photos.
  - Nested replies for every comment.
  - Add new comments.
  - Reply to specific comments.
- **Create New Post**:
  - Create a new post.
  - Create a new post with a background color. An expandable animated color palate menu has been implemented.
- **UI Enhancements**:
  - Transitions and Shimmer Loadings.
  - Responsiveness to handle long feed posts and adaptability for various screen sizes.
  - Elegant Alert Dialogues (Toast, Success, Failed).
- **Error Handling and Architecture**:
  - Rich exception handling and route management.
  - MVC architecture.

---

## Technical Details
- **State Management**: GetX
- **Icon Pack**: HugeIcons Standard


---

## Design Keynotes
- **Gradient Colors**:
  - Matches exactly as mentioned in the API docs.
  - An expandable animated color palate menu has been implemented which user will see while creating a post and can pick color for his post's background.
- **Hero Transition**:
  - From the New Post Box on the home screen to the main New Post Screen, a hero transition ensures the user feels they are typing in the same text field.
- **Feed Post Design**:
  - Multiple images are perfectly centered with a border-radius while maintaining the original ratio.
  - The feed is enabled infinity scrolling that manages the pagination. 
  - Feed post main content text size is adaptable to the length of the post. Short posts appear with larger fonts, enhancing readability.
  - For the feed post that has a background color, will be applied with different constraints, such as minimum height has been set (As same approach as facebook.com).
- **User Profile Integration**:
  - Every post and comment shows its creator’s user profile picture fetched from the API endpoint.
- **Handled Scenarios**:
  - Supports all feed post scenarios:
    - Only image, only text, image with small text, image with larger text, text with background color, and text/image with background color.
- **Reaction Panel**:
  - Long pressing on the Like button expands the full reaction panel.

---

## Functionalities Keynotes
- **Dynamic Feed Updates**:
  - Feed dynamically updates at certain intervals in the background.
- **Thread Management**:
  - The feed fetching process runs in a different thread, ensuring smooth app execution.
- **Instant Updates**:
  - Like and comment counts update instantly and reflect past actions.
    - Example: If the user has already liked a post, the LIKE button is highlighted, and the user can remove the reaction by clicking it again. This works for other reactions as well.
- **Comment Likes**:
  - Not implemented due to the absence of an API endpoint.
- **Replies**:
  - Replies are collapsed by default. Clicking on them loads and displays the replies.
  - This approach reduces the number of read requests and prevents unnecessary user distractions.
  

---

## Screenshots (taken on iOS Simulator)

<p align="center">
  <img src="https://github.com/user-attachments/assets/28cd16ee-8d81-4dad-9858-27af40b1a485" alt="Screenshot 7" width="200" hspace="10" vspace="10"/>
  <img src="https://github.com/user-attachments/assets/df33295f-22d9-4c73-ac8c-6069a1ee2963" alt="Screenshot 1" width="200" hspace="10" vspace="10"/>
  <img src="https://github.com/user-attachments/assets/286ff2f0-5cdc-48e9-8e82-83d1ab9b1d4a" alt="Screenshot 2" width="200" hspace="10" vspace="10"/>
</p>

<p align="center">
  <img src="https://github.com/user-attachments/assets/f6d8f176-00ec-4316-a154-d4f418216f4d" alt="Screenshot 3" width="200" hspace="10" vspace="10"/>
  <img src="https://github.com/user-attachments/assets/7797ba38-27ca-4f2e-a310-59680d99cd10" alt="Screenshot 8" width="200" hspace="10" vspace="10"/>
  <img src="https://github.com/user-attachments/assets/b86a5501-9665-4fc5-be74-b3770dabe85b" alt="Screenshot 4" width="200" hspace="10" vspace="10"/>
</p>

<p align="center">
  <img src="https://github.com/user-attachments/assets/ea775d10-3b94-4a7e-80d9-ebecbf64e5d9" alt="Screenshot 9" width="200" hspace="10" vspace="10"/>
  <img src="https://github.com/user-attachments/assets/232d189a-cf29-41a4-afa5-381c25dcf395" alt="Screenshot 6" width="200" hspace="10" vspace="10"/>
  <img src="https://github.com/user-attachments/assets/c47f0746-296b-4f44-9d54-9e34e4846cc4" alt="Screenshot 5" width="200" hspace="10" vspace="10"/>
</p>



---

## How to Run the Flutter App
> The common apk file has ben uploaded to the Releases. Download it from there or run the flutter project.

1. **Install Flutter**:
   - [Download Flutter SDK](https://flutter.dev/docs/get-started/install).
   - Add Flutter to your system's PATH.

2. **Clone the Repo**
     ```bash
       git clone https://github.com/tanvir-robin/appifylab-task.git
2. **Run the App**:
   - **Android**:
     - Ensure an emulator is running or a physical device is connected.
     - Run:
       ```bash
       cd <project_folder>
       flutter pub get all
       flutter run
       ```
   - **iOS**:
     - Open the project in Xcode to set up the iOS simulator.
     - Run:
       ```bash
       cd <project_folder>/ios
       pod install
       flutter run
       ```

3. **Debugging and Hot Reload**:
   - Use `r` in the terminal during development for hot reload.

---

## Acknowledgments
Thank you to AppifyLab for the opportunity to work on this assessment and showcase these implementations.
