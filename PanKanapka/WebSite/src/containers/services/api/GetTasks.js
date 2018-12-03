async function GetTasks(props) {
    var response = await fetch('http://localhost:5000/api/Tasks?WorkerIds='+props.WorkerIds+'&Date='+props.Date+'&DaysBefore='+props.DaysBefore+'&DaysAfter='+props.DaysAfter,
    {
        method:"POST"
    }) 
    return response
}
export default GetTasks;    