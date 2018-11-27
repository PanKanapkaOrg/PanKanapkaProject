import React, { Component } from "react";
import GetClientFirms from "../services/api/GetClientFirms";
import GetWorkers from "../services/api/GetWorkers";

import "./Firm.css";

export default class Home extends Component {
    constructor(props) {
        super(props);

        this.state = {
            ClientFirms: [],
            Workers: [],
        };
    }

    componentDidMount() {
        GetClientFirms(this.props)
                .then(firms => this.setState({ClientFirms:firms}));
        GetWorkers(this.props)
                .then(workers => this.setState({Workers:workers}));
    }
    
    render() {
           return (
            <div className="Home">
                <div className="lander">
                    <img src="/logo.png" alt="logo"></img>
                    <h1>    {this.props.cateringFirmName}  </h1>
                    <img src="/logo.png" alt="logo"></img>
                    <div>

                        <table className="striped">
                            <thead>
                                <tr><th><h5>Firmy, z którymi współpracujesz</h5></th></tr>
                                <tr>
                                    <th>Nazwa firmy</th>
                                    <th>Adres firmy</th>
                                </tr>
                            </thead>
                            <tbody>
                                {
                                    this.state.ClientFirms.map((ClientFirms) =>
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
                        <table className="striped">

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
    }
}