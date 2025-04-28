# EcoGPT

EcoGPT is a macOS menu bar application that helps users track and understand the environmental impact of their ChatGPT usage. By monitoring your prompts in real-time, EcoGPT provides immediate feedback on the carbon footprint of your AI interactions.

*Inspired by the need for more sustainable AI usage.*

## Features

- 🍃 Real-time carbon footprint tracking for ChatGPT prompts
- 📊 Visual feedback through color-coded menu bar icon (green/yellow/red)
- 🔄 Automatic monitoring of ChatGPT usage
- 📱 Support for different GPT models (GPT-3.5, GPT-4)
- 🌍 Realistic emission intensity calculations
- 📝 Equivalent impact comparisons (e.g., "Sending a simple email")

## Installation

1. Download the latest release from the [releases page](https://github.com/yourusername/ecogpt/releases)
2. Drag EcoGPT to your Applications folder
3. Launch the application
4. Grant necessary permissions when prompted

## How Carbon Footprint is Estimated 🌱

EcoGPT calculates the environmental impact of your ChatGPT usage using a scientifically-based approach:

1. **Token Counting**: The app uses a BPE (Byte Pair Encoding) tokenizer to accurately count the number of tokens in your prompts, similar to how GPT models process text.

2. **Energy Consumption**: Based on research data, the app estimate energy usage at approximately 0.0002 kWh per 1000 tokens for GPT-3.5, with appropriate multipliers for different models (e.g., GPT-4 uses more energy).

3. **Carbon Conversion**: The energy consumption is converted to CO₂ emissions using real-world emission intensity factors, which vary based on your selected region and energy mix.

4. **Error Margin**: To account for variations in data center efficiency and other factors, the app applies a ±20% margin of error to our estimates.

5. **Equivalent Impact**: The app provides relatable comparisons to help you understand the impact (e.g., "equivalent to sending a simple email" or "watching 1 minute of HD video").

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.



