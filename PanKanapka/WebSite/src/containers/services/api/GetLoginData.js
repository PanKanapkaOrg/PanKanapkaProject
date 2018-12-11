async function GetLoginData(props) {
        var response = await fetch('http://localhost:5000/api/Login?from=web&mail='+props.email+'&password='+props.password,
        {
            method:"GET"
        }) 
        return response
}
export default GetLoginData;    