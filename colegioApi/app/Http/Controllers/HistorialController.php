<?php

namespace App\Http\Controllers;

use App\Models\Historial;
use Illuminate\Http\Request;
use App\Http\Requests\ResquestHistorial;
class HistorialController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        return Historial::all();
    }
    public function getXRut(string $rut_alumno){
        return Historial::select('cod_historial', 'descripcion', 'tipo_evento', 'fecha', 'hora',  'rut_alumno')
        ->where('rut_alumno', '=', $rut_alumno)->get();
    }
    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(ResquestHistorial $request)
    {
        $historial = new Historial();
        $historial->cod_historial = $request->cod_historial;
        $historial->descripcion = $request->descripcion;
        $historial->tipo_evento = $request->tipo_evento;
        $historial->fecha = $request->fecha;
        $historial->hora = $request->hora;
        $historial->rut_alumno = $request->rut_alumno;
        $historial->save();
        return  $historial;
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\Historial  $historial
     * @return \Illuminate\Http\Response
     */
    public function show(Historial $historial)
    {
        return $historial;
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\Models\Historial  $historial
     * @return \Illuminate\Http\Response
     */
    public function edit(Historial $historial)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\Historial  $historial
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, Historial $historial)
    {
        $historial->descripcion = $request->descripcion;
        $historial->tipo_evento = $request->tipo_evento;
        $historial->fecha = $request->fecha;
        $historial->hora = $request->hora;
        $historial->save();
        return $historial;
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\Historial  $historial
     * @return \Illuminate\Http\Response
     */
    public function destroy(Historial $historial)
    {
        $historial->delete();
        return $historial;
    }
}
