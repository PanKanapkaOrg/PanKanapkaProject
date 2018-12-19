async function GetWorkers(props) {
    var response = await fetch('http://localhost:5000/api/Workers/' + props.cateringFirmId);
    return response.json();
}
export default GetWorkers