package main

import (
    "encoding/json"
    "fmt"
    "log"
    "net/http"
)

type BMIRequest struct {
    WeightKg float64 `json:"weight_kg"`
    HeightM  float64 `json:"height_m"`
}

type BMIResponse struct {
    BMI float64 `json:"bmi"`
}

func calculateBMI(w http.ResponseWriter, r *http.Request) {
    var req BMIRequest
    err := json.NewDecoder(r.Body).Decode(&req)
    if err != nil {
        http.Error(w, "Bad request", http.StatusBadRequest)
        return
    }

    bmi := req.WeightKg / (req.HeightM * req.HeightM)
    response := BMIResponse{BMI: bmi}

    w.Header().Set("Content-Type", "application/json")
    json.NewEncoder(w).Encode(response)
}

func main() {
    http.HandleFunc("/calculate_bmi", calculateBMI)
    fmt.Println("Starting server on port 8080...")
    log.Fatal(http.ListenAndServe(":8080", nil))
}
