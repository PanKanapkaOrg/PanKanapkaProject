import React, { Component } from "react";
import "./Home.css";

export default class Home extends Component {
    constructor(props) {
        super(props);


        this.state = {
            ClientFirms: [],
            Workers: [],
        };
    }
    componentDidMount() {
        fetch('http://localhost:5000/api/ClientFirms/' + this.props.CateringFirmId)
            .then((response) => response.json())
            .then((findresponse) => {
                console.log(findresponse)
                this.setState({
                    ClientFirms: findresponse,
                })
            })
        fetch('http://localhost:5000/api/Workers/' + this.props.CateringFirmId)
            .then((response) => response.json())
            .then((findresponse) => {
                console.log(findresponse)
                this.setState({
                    Workers: findresponse,
                })
            })
    }
    render() {
        if (this.props.isAuthenticated) return (
            <div className="Home">
                <div className="lander">
                    <img src="/logo.png"></img>
                    <h1>    {this.props.CateringFirmName}  </h1>
                    <img src="/logo.png"></img>
                    <div>

                        <table class="striped">
                            <thead>
                                <tr><th><h5>Firmy, z którymi współpracujesz</h5></th></tr>
                                <tr>
                                    <th>Nazwa firmy</th>
                                    <th>Adres firmy</th>
                                </tr>
                            </thead>
                            <tbody>

                                {
                                    this.state.ClientFirms.map((ClientFirms, i) =>
                                        <tr>
                                            <td>
                                                <p key={ClientFirms.id}>{ClientFirms.name}</p>
                                            </td>
                                            <td>
                                                <p key={ClientFirms.id}>{ClientFirms.address}</p>
                                            </td>
                                        </tr>
                                    )
                                }

                            </tbody>

                        </table>
                        <table class="striped">

                            <thead>
                                <tr><th><h5>Twoi pracownicy</h5></th></tr>
                                <tr>
                                    <th>Imie</th>
                                    <th>Nazwisko</th>
                                </tr>
                            </thead>
                            <tbody>
                                {
                                    this.state.Workers.map((Workers, i) =>
                                        <tr>
                                            <td>
                                                <p key={Workers.id}>{Workers.name}</p>
                                            </td>
                                            <td>
                                                <p key={Workers.id}>{Workers.surname}</p>
                                            </td>
                                        </tr>
                                    )
                                }

                            </tbody>

                        </table>
                    </div>
                </div>
            </div>

        )
        return (
            <div className="Home">
                <div className="lander">
                    <h1>Witaj w serwisie Pan Kanapka</h1>
                    <p>Zaloguj się aby przejść do panelu managera</p>
                </div>
            </div>
        );
    }
}