# Flutter Note Application

This is a simple Note application developed using Flutter for the front end and Nest.js for the back end. The backend API is designed to handle note-related operations, and the entire backend is organized in the `Backend` folder. The data is stored in a temporary list in the backend and no database is used, Hence the note is not stored permanently in the server.

## Features

- **Create**: Easily create and save new notes.
- **Read**: View and manage your existing notes.
- **Update**: Edit and update your notes on the fly.
- **Delete**: Remove unwanted notes effortlessly.

## Backend Setup

### Prerequisites

- [Node.js](https://nodejs.org/) installed.
- [Yarn](https://yarnpkg.com/getting-started/install) globally installed.

### Installation

1. Clone the repository.

   ```bash
   git clone https://github.com/your-username/your-repository.git
   
2. Navigate to the Backend folder in your terminal.
   ```bash
   cd your-repository/Backend
3. Install Yarn globally.
   ```bash
   npm install --global yarn
4. Install project dependencies.
   ```bash
   yarn install
5. Run the server
   ```bash
   #development mode
   yarn start:dev
   #production mode
   yarn start:prod

   

  
