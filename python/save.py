import argparse
import cv2
import numpy as np
import os
import requests
import urllib.parse

def remove_watermark(image_path, output_path):
    # Load the image
    image = cv2.imread(image_path)

    # Determine the coordinates of the region to remove
    bottom_left_x = 0
    bottom_left_y = image.shape[0] - 50
    top_right_x = 50
    top_right_y = image.shape[0]

    # Create a mask for the main region to remove
    mask = np.zeros(image.shape[:2], dtype=np.uint8)
    mask[bottom_left_y:top_right_y, bottom_left_x:top_right_x] = 255

    # Pre-process the image (optional)
    # Apply image denoising or blurring techniques

    # Inpaint the main region
    image_without_watermark = cv2.inpaint(image, mask, 3, cv2.INPAINT_TELEA)

    # Create a mask for the remaining small region to remove
    small_mask = np.zeros(image.shape[:2], dtype=np.uint8)
    small_mask[-60:, :15] = 255

    # Inpaint the remaining small region
    image_without_watermark = cv2.inpaint(image_without_watermark, small_mask, 3, cv2.INPAINT_TELEA)

    # Post-process the image (optional)
    # Apply additional adjustments or refinements, such as blending or texture synthesis

    # Save the image without the watermark
    cv2.imwrite(output_path, image_without_watermark)

# Parse command-line arguments
parser = argparse.ArgumentParser()
parser.add_argument('-U', '--url', help='URL of the image')
parser.add_argument('-P', '--path', help='Path to save the image')
args = parser.parse_args()

# Input folder
input_folder = "temp"

# Create the input folder if it doesn't exist
if not os.path.exists(input_folder):
    os.makedirs(input_folder)

# Download the image file
response = requests.get(args.url)
filename = urllib.parse.unquote(os.path.basename(args.url))
image_path = os.path.join(input_folder, filename)

with open(image_path, 'wb') as f:
    f.write(response.content)

# Remove watermark and save the image
output_filename = os.path.splitext(filename)[1].replace('.', '') + ".jpeg"
output_path = os.path.join(args.path, output_filename)
remove_watermark(image_path, output_path)

# Remove the temporary file
os.remove(image_path)
