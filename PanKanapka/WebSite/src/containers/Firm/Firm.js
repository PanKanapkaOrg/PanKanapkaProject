import React, { Component } from "react";
import GetClientFirms from "../services/api/GetClientFirms";
import GetWorkers from "../services/api/GetWorkers";
import CircularSpinnerLoading from "../CircularSpinnerLoading";
import Modal from "react-modal"
import AddWorkerModal from "./AddWorkerModal";
import "./Firm.css";

export default class Home extends Component {
    constructor(props) {
        super(props);

        this.state = {
            isLoading: true,
            ClientFirms: [],
            Workers: [],
            showAddWorkerModal: false
        };
    }

    componentDidMount() {
        document.title = "Firma - Serwis kateringowy"; //tytul dla przegladarki
        GetClientFirms(this.props)
            .then(firms => this.setState({ ClientFirms: firms }));
        this.loadWorkers()
    }
    loadWorkers=()=>{
        this.setState({isLoading:true})
        GetWorkers(this.props)
        .then(workers => {
            window.setTimeout(() => this.setState({ Workers: workers, isLoading: false }), 500);
        });

    }
    closeModal = (reload) => {
        this.setState({
            showAddWorkerModal:false,
            display: null
        });
        if (reload) {
            this.loadWorkers();
        }
    }

    render() {
        if (this.state.isLoading) {
            return <div className="Home"><div className="lander"><CircularSpinnerLoading /> </div></div>
        }
        else {
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
                                    <tr><th>
                                        <h5>Twoi pracownicy
                                        </h5>
                                    </th>
                                    <button
                                            style={{display:this.state.display}}
                                            className="addWorker btn waves-effect #1a237e indigo darken-4"
                                            onClick={() => {
                                                this.setState({ showAddWorkerModal: true, display:'none' })
                                            }}>
                                            <i className="material-icons right">add</i>
                                        </button></tr>
                                    <tr>
                                        <th>Lp.</th>
                                        <th>Imie</th>
                                        <th>Nazwisko</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    {
                                        this.state.Workers.map((Workers, i) =>
                                            <tr>
                                                <td><p key={i}>{i + 1}</p></td>
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
                            <Modal
                                isOpen={this.state.showAddWorkerModal}
                                contentLabel="Example Modal">
                                <AddWorkerModal
                                    onClose={(reload) => this.closeModal(reload)}
                                    cateringFirmId={this.state.cateringFirmId} />
                            </Modal>
                        </div>
                    </div>
                </div>
            )

        }
    }
}