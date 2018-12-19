import axios from "axios";

async function GetTasks(taskFilter) {
        
    var response = await axios.post('http://localhost:5000/api/Tasks', taskFilter);
      
    return response
}
export default GetTasks;    