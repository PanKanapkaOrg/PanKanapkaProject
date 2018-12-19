async function GetClientFirms(props) {
    var response = await fetch('http://localhost:5000/api/ClientFirms/' + props.cateringFirmId);
    return response.json();
}
export default GetClientFirms
