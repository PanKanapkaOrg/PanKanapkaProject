import React, { Component } from "react";
import GetTasks from "../services/api/GetTasks";
import GetClientFirms from "../services/api/GetClientFirms";
import GetWorkers from "../services/api/GetWorkers";
import CircularSpinnerLoading from "../CircularSpinnerLoading";
import Modal from 'react-modal';
import CreateTaskModal from "./CreateTaskModal"
import ConfirmDeleteModal from "./ConfirmDeleteModal"
import "./plans.css";

export default class Plans extends Component {
    constructor(props) {
        super(props);
        //var currentDay = new Date('2018-10-27');
        var currentDay = new Date();
        this.state = {
            isLoading: true,
            ClientFirms: [],
            Workers: [],
            Tasks: [],
            UnusedFirms: new Map(),
            Today: currentDay,
            ChoosenDay: currentDay,
            isModalDisplay: false,
            choosenWorker: null,
            choosenDate: null,
            choosenFirms: null,
            display: null,
            toDelete:null,
            showConfirmDeleteModal:false
        };
    }

    getMonday = (date) => {
        var d = new Date(date);
        d.setDate(d.getDate() - (d.getDay() + 6) % 7);
        return d;
    }

    loadTasks = () => {
        this.setState({ isLoading: true });

        GetClientFirms(this.props)
            .then(firms => this.setState({ ClientFirms: firms }));
        GetWorkers(this.props)
            .then(workers => {
                var taskFilter = {
                    WorkerIds: workers.map(w => w.id),
                    Date: this.getMonday(this.state.ChoosenDay),
                    DaysBefore: 0,
                    DaysAfter: 7
                }

                GetTasks(taskFilter)
                    .then(tasks => {
                        window.setTimeout(() => this.setState({ Tasks: tasks.data, Workers: workers, isLoading: false }), 1000);
                    });
            });
    }

    componentDidMount() {
        this.loadTasks();
    }

    closeModal = (reload) => {
        this.setState({
            showConfirmDeleteModal:false,
            isModalDisplay: false,
            display: null
        });
        if (reload) {
            this.loadTasks();
        }
    }

    render() {
        if (this.state.isLoading) {
            return <CircularSpinnerLoading />
        }
        else {
            console.log("Tasks is = ", Array.isArray(this.state.Tasks));
            if (Array.isArray(this.state.Tasks)) {
                console.log(this.state.ClientFirms);
                console.log(this.state.Tasks);
            }

            this.state.UnusedFirms.clear();

            this.state.Tasks[0].taskItems.forEach((item) => {
                this.state.UnusedFirms.set(item.date, this.state.ClientFirms);
            });
            console.log("Unused firms = ", this.state.UnusedFirms);
            return (
                <div className="Home">
                    <div className="lander">
                        <h1>Plany dla pracowników</h1><br></br>

                        <table className="highlight centered">
                            <thead>
                                <tr>
                                    <th>Pracownik</th>
                                    {
                                        this.state.Tasks[0].taskItems.map((item) => {
                                            var date = new Date(item.date);
                                            var dateStr = new Date(item.date).toLocaleDateString('PL-pl');
                                            var style = {
                                                color: 'red',
                                                fontWeight: 'bold'
                                            };

                                            if (date.getDate() == this.state.Today.getDate()) {
                                                return <th style={style}>{dateStr}</th>
                                            }
                                            else {
                                                return <th>{dateStr}</th>;
                                            }
                                        }
                                        )
                                    }
                                </tr>
                            </thead>
                            <tbody>
                                {
                                    this.state.Tasks.map((task) =>
                                        <tr className="wiersz">

                                            <td>
                                                {task.worker.name} {task.worker.surname}
                                            </td>
                                            {
                                                task.taskItems.map((taskItem) => {
                                                    var newArray = this.state.UnusedFirms.get(taskItem.date).filter(item => {
                                                        //console.log("item id = ", item.id);
                                                        return -1 === taskItem.firms.findIndex(firm => firm.id == item.id);
                                                    });
                                                    this.state.UnusedFirms.set(taskItem.date, newArray);
                                                    //console.log("Unsused firms = ", taskItem.date, newArray, task.worker.name);
                                                    //console.log(Date.parse(taskItem.date), this.state.Today);

                                                    return (<td className="komorka">
                                                        <ul>
                                                            {taskItem.firms.map((firm) => {
                                                                return (<li>
                                                                    <button className="usun" onClick={()=>{
                                                                        this.setState({showConfirmDeleteModal:true, toDelete:firm.taskId})}
                                                                    }>
                                                                        <span className="nazwa_firmy">{firm.name}</span>
                                                                        <i className="material-icons right">clear</i>
                                                                    </button>
                                                                </li>)
                                                            }
                                                            )}
                                                        </ul>
                                                        <button
                                                            className="btn waves-effect #1a237e indigo darken-4 add-plan"
                                                            style={{ display: this.state.display }}
                                                            onClick={() => {
                                                                this.setState({ display: 'none', isModalDisplay: true, choosenWorker: task.worker, choosenDate: taskItem.date, choosenFirms: this.state.UnusedFirms.get(taskItem.date) })
                                                            }}><i className="material-icons center">add</i></button>
                                                    </td>)
                                                }
                                                )
                                            }
                                        </tr>
                                    )
                                }

                                <tr>

                                    <td>
                                        <b>Nieuzyte firmy</b>
                                    </td>
                                    {
                                        Array.from(this.state.UnusedFirms, ([key, value]) =>
                                            <td className="komorka">
                                                <ul>
                                                    {
                                                        value.map((firm) => <li>{firm.name}</li>)
                                                    }
                                                </ul>
                                            </td>
                                        )
                                    }
                                </tr>

                            </tbody>
                        </table>
                        <Modal style="height:100px"
                            isOpen={this.state.showConfirmDeleteModal}
                            contentLabel="Example Modal">
                            <ConfirmDeleteModal style="height:100px"
                                id={this.state.toDelete}
                                onClose={(reload)=>this.closeModal(reload)} />
                        </Modal>)
                        <Modal
                            isOpen={this.state.isModalDisplay}
                            contentLabel="Example Modal">
                            <CreateTaskModal
                                worker={this.state.choosenWorker}
                                date={this.state.choosenDate}
                                clientFirms={this.state.choosenFirms}
                                onClose={(reload) => this.closeModal(reload)} />
                        </Modal>
                    </div>
                </div>
            );
        }
    }
}