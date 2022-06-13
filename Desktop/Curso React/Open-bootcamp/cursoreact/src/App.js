import logo from './logo.svg';
import './App.css';
import TaskListComponet from './components/container/task_list';
import ContactList from './components/container/contact_list';

function App() {
  return (
    <div className="App">
      <header className="App-header">
        <img src={logo} className="App-logo" alt="logo" />
      
      {/*  <TaskListComponet/> */}
      <ContactList/>
      </header>
    </div>
  );
}

export default App;
